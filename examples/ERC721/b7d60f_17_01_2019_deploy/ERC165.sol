// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;



contract ERC165  {
    bytes4 private constant _INTERFACE_ID_ERC165 = 0x01ffc9a7;
    /**
     * 0x01ffc9a7 ===
     *     bytes4(keccak256('supportsInterface(bytes4)'))
     */

    mapping(bytes4 => bool) private _supportedInterfaces;


    constructor () public {
        _registerInterface(_INTERFACE_ID_ERC165);
    }
 
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff);
        _supportedInterfaces[interfaceId] = true;
    }
}
