# @version >=0.2.4 <0.3.0

DNA_DIGITS: constant(uint256) = 16
DNA_MODULUS: constant(uint256) = 10 ** DNA_DIGITS
HP_LIMIT: constant(uint256) = 1000

#pokemon "token"
struct Pokemon:
    name: String[32]
    dna: uint256
    HP: uint256
    matches: uint256
    wins: uint256

#trainer "Etherium account"
struct Trainer:
    name: String[32]

totalPokemonCount: public(uint256)                  #total number of pokemon created

trainerPokemonCount: HashMap[address, uint256]      #Trainer to # of pokemon they own
pokemonList: HashMap[uint256, Pokemon]              #pokemon created # to the pokemon
trainerList: HashMap[address, Trainer]              #account address to their respective trainer
trainerToPokemon: HashMap[address, HashMap[uint256, Pokemon]]   #trainer address to the list of pokemon they own (same as trainer list)

#fire w/e a new pokemon is created
event NewPokemonCreated:
    name: String[32]
    dna: uint256
    HP: uint256

#fire w/e a new Trainer account is made
event NewTrainerCreated:
    name: String[32]

@pure
@internal
def _generateRandomDNA(_name: String[32]) -> uint256:
    random: uint256 = convert(keccak256(_name), uint256)
    return random % DNA_MODULUS

@internal
def _createPokemon(_name: String[32]) -> Pokemon:
    randomDNA: uint256 = self._generateRandomDNA(_name)
    randomHP: uint256 = randomDNA % HP_LIMIT
    newPokemon: Pokemon = Pokemon({
        name: _name,
        dna: randomDNA,
        HP: randomHP,
        matches: 0,
        wins: 0
    })

    self.pokemonList[self.totalPokemonCount] = newPokemon
    self.totalPokemonCount += 1

    log NewPokemonCreated(_name, randomDNA, randomHP)

    return newPokemon

@external
def createTrainer(trainerName: String[32], pokemonName: String[32]):
    newPokemon: Pokemon = self._createPokemon(pokemonName)     #makes a new pokemon token for the new trainer
    newTrainer: Trainer = Trainer({name: trainerName})         #make a new trainer
    self.trainerList[msg.sender] = newTrainer                  #add the new trainer to the map of addresses of trainers 
    self.trainerToPokemon[msg.sender][self.trainerPokemonCount[msg.sender]] = newPokemon
    self.trainerPokemonCount[msg.sender] += 1

    log NewTrainerCreated(trainerName)