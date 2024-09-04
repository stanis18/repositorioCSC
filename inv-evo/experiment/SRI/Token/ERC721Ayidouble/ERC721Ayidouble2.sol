pragma solidity >=0.5.0;


// Link to contract source code:
// https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/token/ERC721/ERC721.sol


contract ERC721_Spec {

    //bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;
    //bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;

    // Mapping from token ID to owner
    mapping (uint => address) public _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint => address) public _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => uint) public _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) public _operatorApprovals;


    /** @notice precondition owner != address(0)
    */
    function balanceOf(address owner) public view returns (uint) {
        return _ownedTokensCount[owner];
    }

        constructor () public {
        _operatorApprovals[address(1)][address(2)] = true;
        _operatorApprovals[address(2)][address(1)] = true;
    }



    function ownerOf(uint tokenId) public view returns (address) {
        //address owner = _tokenOwner[tokenId];

        return _tokenOwner[tokenId];
    }



    /** @notice precondition to != address(0)
        @notice precondition msg.sender == _tokenOwner[tokenId]
        @notice postcondition _tokenApprovals[tokenId] == to
        @notice modifies _tokenApprovals[tokenId]
    */
    function approve(address to, uint tokenId) external {
        _tokenApprovals[tokenId] = to;
    }


    function getApproved(uint tokenId) public view returns (address) {
        return _tokenApprovals[tokenId];
    }


    /** @notice precondition to != address(0)
        @notice postcondition  _operatorApprovals[msg.sender][to] == approved
        @notice modifies _operatorApprovals[msg.sender][to]
    */
    function setApprovalForAll(address to, bool approved) public {
        _operatorApprovals[msg.sender][to] = approved;
    }

    /** @notice precondition owner != address(0)
        @notice precondition operator != address(0)
    */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /** @notice precondition from == _tokenOwner[tokenId]
        @notice precondition to != address(0)
        @notice precondition _ownedTokensCount[from] >= 1
        @notice postcondition from != to || _ownedTokensCount[to] == __verifier_old_uint(_ownedTokensCount[to])
        @notice postcondition from == to || _ownedTokensCount[from] == __verifier_old_uint(_ownedTokensCount[from]) - 1
        @notice postcondition from == to || _ownedTokensCount[to] == __verifier_old_uint(_ownedTokensCount[to]) + 1
        @notice postcondition  _tokenOwner[tokenId] == to
        @notice modifies _ownedTokensCount[from]
        @notice modifies _ownedTokensCount[to]
        @notice modifies _tokenOwner[tokenId]
        @notice modifies _tokenApprovals[tokenId]
    */
    function transferFrom(address from, address to, uint tokenId) public {
        _transferFrom(from, to, tokenId);
    }


    /** @notice precondition from == _tokenOwner[tokenId]
        @notice precondition to != address(0)
        @notice precondition _ownedTokensCount[from] >= 1
        @notice postcondition from != to || _ownedTokensCount[to] == __verifier_old_uint(_ownedTokensCount[to])
        @notice postcondition from == to || _ownedTokensCount[from] == __verifier_old_uint(_ownedTokensCount[from]) - 1
        @notice postcondition from == to || _ownedTokensCount[to] == __verifier_old_uint(_ownedTokensCount[to]) + 1
        @notice postcondition  _tokenOwner[tokenId] == to
        @notice modifies _ownedTokensCount[from]
        @notice modifies _ownedTokensCount[to]
        @notice modifies _tokenOwner[tokenId]
        @notice modifies _tokenApprovals[tokenId]
    */
    function _transferFrom(address from, address to, uint tokenId) internal {
        _clearApproval(tokenId);

        _ownedTokensCount[from]--;
        _ownedTokensCount[to]++;

        _tokenOwner[tokenId] = to;
    }

    /** @notice postcondition  _tokenApprovals[tokenId] == address(0)
        @notice modifies _tokenApprovals[tokenId]
    */
    function _clearApproval(uint tokenId) private {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }

}
