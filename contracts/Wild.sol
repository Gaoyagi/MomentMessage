pragma solidity ^0.7.0;

contract Wild {
    struct Pokemon {
        uint256 name; // name of pokemon
        uint256 dna; // hash
        uint256 HP; // Health of pokemon
        uint256 matches; // matches a pokemon has participated in
        uint256 wins; // wins a pokemon has
    }

    uint256 constant public DNA_DIGITS = 16;
    uint256 constant public DNA_MODULUS = 10 ** DNA_DIGITS;
    uint256 constant public HP_LIMIT = 1000;
    uint256 constant public NAME_MODULUS = 20;
    uint256 battleCount;
    mapping (uint256 => string) pokemonNames;

    
    
}