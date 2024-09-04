pragma solidity ^0.5.0;


// Link to contract source code:
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/introspection/ERC165.sol


contract ERC165_Spec {

    bytes4 public constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;


    mapping(bytes4 => bool) public _supportedInterfaces;


    /**
        @notice postcondition  _supportedInterfaces[_INTERFACE_ID_ERC165] == true
        @notice modifies  _supportedInterfaces[_INTERFACE_ID_ERC165]
    */
    constructor () public {
        _registerInterface(_INTERFACE_ID_ERC165);
    }


    function supportsInterface(bytes4 interfaceId) public view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
        @notice postcondition   _supportedInterfaces[interfaceId] == true
        @notice modifies  _supportedInterfaces[interfaceId]
    */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
}

}