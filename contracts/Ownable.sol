pragma solidity >=0.4.22 <0.8.0;



//is each block 1 message qith 1 owner?

//deals with who owns the block an permissions to access the block
contract Ownable {
    address public owner;     //account address of the current owner of the message(/block?)

    //fire  whenever block ownershipis given up
    event OwnershipRenounced(address indexed previousOwner);
    
    //fire w/e block ownership is changed
    event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
    );


    //upon creation of message(/block?) set the owner 
    constructor() public {
    owner = msg.sender;
    }

   
    //modifier restriction that can be added to function where only the message owner can call this function
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    //function that makes a message(/block?) ownerless, can only be called  by current owner
    function renounceOwnership() public onlyOwner {
        emit OwnershipRenounced(owner);
        owner = address(0);
    }

    //intent to change block ownership
    function transferOwnership(address _newOwner) public onlyOwner {
        _transferOwnership(_newOwner);
    }

    //transfers message(/block?) ownership 
    function _transferOwnership(address _newOwner) internal {
    require(_newOwner != address(0));
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
    }
}

