pragma solidity ^0.5.0;

// Link to contract source code:
// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/access/roles/WhitelistedRole.sol
// removed links to Whitelistedadmins and ownable contracts

contract Whitelisted1  {

    mapping (address => bool) public _whitelisteds;

    address public owner;

    /** @notice postcondition owner == msg.sender
        @notice modifies owner
    */
    constructor() public {
        owner = msg.sender;
    }

    function isWhitelisted(address account) public view returns (bool) {
        return _whitelisteds[account];
    }

    /** @notice precondition msg.sender == owner
        @notice postcondition _whitelisteds[account] == true
        @notice modifies _whitelisteds[account]
    */
    function addWhitelisted(address account) public  {
         require(msg.sender == owner);
        _whitelisteds[account] = true;
    }

    /** @notice precondition msg.sender == owner
        @notice postcondition _whitelisteds[account] == false
        @notice modifies _whitelisteds[account]
    */
    function removeWhitelisted(address account) public  {
        require(msg.sender == owner);
        _whitelisteds[account] = false;
    }

    // /** @notice precondition _whitelisteds[msg.sender] == true
    //     @notice postcondition _whitelisteds[msg.sender] == false
    //     @notice modifies _whitelisteds[msg.sender]
    // */
    // function renounceWhitelisted() public {
    //     _whitelisteds[msg.sender] = false;
    // }

}