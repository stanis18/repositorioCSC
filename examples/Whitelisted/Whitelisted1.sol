pragma solidity ^0.5.0;

// Link to contract source code:
// https://github.com/hanzoai/solidity/blob/master/contracts/Whitelist.sol
// removed link to ownable contract

/**
  @notice simulation __verifier_eq(Whitelist.whitelist, WhitelistedRole._whitelisteds)
  @notice simulation Whitelist.owner == WhitelistedRole.owner
 */
contract Whitelisted2  {

    mapping (address => bool) public whitelist;
    uint public length;

    address public owner;


    /** @notice modifies owner
    */
    constructor() public {
        owner = msg.sender;
    }

    /** @notice modifies length
        @notice modifies whitelist[account]
    */
    function addWhitelisted(address account) public {
        require(msg.sender == owner);
        whitelist[account] = true;
        length++;
    }

    /** @notice modifies length
        @notice modifies whitelist[account]
    */
    function removeWhitelisted(address account) public {
        require(msg.sender == owner);
        whitelist[account] = false;
        length++;
    }


    function isWhitelisted(address account) public view returns (bool) {
        return whitelist[account];
    }
}