// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

contract ERC721Speci  {
  

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
    mapping (uint256 => address) private _tokenOwner;

    mapping (uint256 => address) private _tokenApprovals;

    mapping (address => uint256) private _ownedTokensCount;

    mapping (address => mapping (address => bool)) private _operatorApprovals;

    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    

    constructor () public {
      
    }

     /// @notice postcondition _ownedTokensCount[owner] == balance
    function balanceOf(address owner) public view returns (uint256 balance) {
 
    }

     /// @notice postcondition _tokenOwner[tokenId] == _owner
     /// @notice postcondition  _owner !=  address(0)
    function ownerOf(uint256 tokenId) public view returns (address _owner) {
     
    }
   
    /// @notice postcondition _tokenOwner[tokenId] == msg.sender || _operatorApprovals[_tokenApprovals[tokenId]][msg.sender]
    /// @notice postcondition _tokenApprovals[tokenId] == to 
    /// @notice emits Approval
    function approve(address to, uint256 tokenId) public {
 
    }


    /// @notice postcondition _tokenOwner[tokenId] != address(0)
    /// @notice postcondition _tokenApprovals[tokenId] == approved
    function getApproved(uint256 tokenId) public view returns (address approved) {
      
    }


    /// @notice postcondition _operatorApprovals[msg.sender][to] == approved
    /// @notice emits ApprovalForAll
    function setApprovalForAll(address to, bool approved) public {
     
    }

    /// @notice postcondition _operatorApprovals[owner][operator] == approved
    function isApprovedForAll(address owner, address operator) public view returns (bool approved) {
    }


    /// @notice  postcondition ( ( _ownedTokensCount[from] ==  __verifier_old_uint (_ownedTokensCount[from] ) - 1  &&  from  != to ) || ( from == to )  ) 
    /// @notice  postcondition ( ( _ownedTokensCount[to] ==  __verifier_old_uint ( _ownedTokensCount[to] ) + 1  &&  from  != to ) || ( from  == to ) )
    /// @notice  postcondition  _tokenOwner[tokenId] == to
    /// @notice  emits Transfer
    function transferFrom(address from, address to, uint256 tokenId) public {
    }

    /// @notice  postcondition ( ( _ownedTokensCount[from] ==  __verifier_old_uint (_ownedTokensCount[from] ) - 1  &&  from  != to ) || ( from == to )  ) 
    /// @notice  postcondition ( ( _ownedTokensCount[to] ==  __verifier_old_uint ( _ownedTokensCount[to] ) + 1  &&  from  != to ) || ( from  == to ) )
    /// @notice  postcondition  _tokenOwner[tokenId] == to
    /// @notice  emits  Transfer
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
    }

    /// @notice  postcondition ( ( _ownedTokensCount[from] ==  __verifier_old_uint (_ownedTokensCount[from] ) - 1  &&  from  != to ) || ( from == to )  ) 
    /// @notice  postcondition ( ( _ownedTokensCount[to] ==  __verifier_old_uint ( _ownedTokensCount[to] ) + 1  &&  from  != to ) || ( from  == to ) )
    /// @notice  postcondition  _tokenOwner[tokenId] == to
    /// @notice  emits  Transfer
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
    }    
   
}
