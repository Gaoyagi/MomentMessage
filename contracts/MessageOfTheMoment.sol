pragma solidity >=0.4.22 <0.8.0;

import "./Ownable.sol";

//createsa brand new message(/block?)
contract MessageOfTheMoment is Ownable {
        string public message;      //public so anybody can view the message
        uint public maxLength;      //or so canyone can see if the message they want to change it to works

    //upon creation set a default message with a 200 char length max
    constructor() public {
        message = "Hello World";
        maxLength = 280;
    }

    //change blockmessage
    function setMessage(string memory _message) public {
        require(bytes(_message).length <= maxLength, "That message is too long."); //checks to see if new message is too long
        message = _message;
    }

    //allows  the owner to change the maximum length of possible messages
    function setMaxLength(uint _maxLength) public onlyOwner {
        maxLength = _maxLength;
    }
}
