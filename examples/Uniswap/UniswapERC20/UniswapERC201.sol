pragma solidity ^0.5.0;

// import './files/IUniswapV2ERC20.sol';
import './files/SafeMath.sol';

contract UniswapERC202 {
    using SafeMath for uint;

    string public constant name = 'Uniswap V2';
    string public constant symbol = 'UNI-V2';
    uint8 public constant decimals = 18;
    uint  public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    uint public constant THRESHOLD = 10**6;
    bytes32 public DOMAIN_SEPARATOR;
    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
    mapping(address => uint) public nonces;

    constructor() public {
        uint chainId;
        // assembly {
        //     chainId := chainid
        // }
        // DOMAIN_SEPARATOR = keccak256(
        //     abi.encode(
        //         keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'),
        //         keccak256(bytes(name)),
        //         keccak256(bytes('1')),
        //         chainId,
        //         address(this)
        //     )
        // );
    }

    /// @notice  emits  Transfer
    function _mint(address to, uint value) internal {
        totalSupply = totalSupply.add(value);
        uint balance = balanceOf[to].add(value);
        require(balance >= THRESHOLD, 'UniswapV2: THRESHOLD');
        balanceOf[to] = balance;
        emit Transfer(address(0), to, value);
    }

    /// @notice  emits  Transfer
    function _burn(address from, uint value) internal {
        uint balance = balanceOf[from].sub(value);
        require(balance == 0 || balance >= THRESHOLD, 'UniswapV2: THRESHOLD');
        balanceOf[from] = balance;
        totalSupply = totalSupply.sub(value);
        emit Transfer(from, address(0), value);
    }

    /// @notice  emits  Approval
    function _approve(address owner, address spender, uint value) private {
        allowance[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /// @notice  emits  Transfer
    function _transfer(address from, address to, uint value) private {
        uint balanceFrom = balanceOf[from].sub(value);
        uint balanceTo = balanceOf[to].add(value);
        require(balanceFrom == 0 || balanceFrom >= THRESHOLD, 'UniswapV2: THRESHOLD');
        require(balanceTo >= THRESHOLD, 'UniswapV2: THRESHOLD');
        balanceOf[from] = balanceFrom;
        balanceOf[to] = balanceTo;
        emit Transfer(from, to, value);
    }

    /// @notice  postcondition (allowance[msg.sender ][ spender] ==  value  &&  success) || ( allowance[msg.sender ][ spender] ==  __verifier_old_uint ( allowance[msg.sender ][ spender] ) && !success )    
    /// @notice  emits  Approval
    function approve(address spender, uint value) external returns (bool success) {
        _approve(msg.sender, spender, value);
        return true;
    }

    /// @notice  postcondition ( ( balanceOf[msg.sender] ==  __verifier_old_uint (balanceOf[msg.sender] ) - value  && msg.sender  != to ) ||   ( balanceOf[msg.sender] ==  __verifier_old_uint ( balanceOf[msg.sender]) && msg.sender  == to ) &&  success )   || !success
    /// @notice  postcondition ( ( balanceOf[to] ==  __verifier_old_uint ( balanceOf[to] ) + value  && msg.sender  != to ) ||   ( balanceOf[to] ==  __verifier_old_uint ( balanceOf[to] ) && msg.sender  == to ) &&  success )   || !success
    /// @notice  emits  Transfer 
    function transfer(address to, uint value) external returns (bool success) {
        _transfer(msg.sender, to, value);
        return true;
    }

    /// @notice  postcondition ( ( balanceOf[from] ==  __verifier_old_uint (balanceOf[from] ) - value  &&  from  != to ) ||   ( balanceOf[from] ==  __verifier_old_uint ( balanceOf[from] ) &&  from== to ) &&  success )   || !success
    /// @notice  postcondition ( ( balanceOf[to] ==  __verifier_old_uint ( balanceOf[to] ) + value  &&  from  != to ) ||   ( balanceOf[to] ==  __verifier_old_uint ( balanceOf[to] ) &&  from  ==to ) &&  success )   || !success
    /// @notice  postcondition  (allowance[from ][msg.sender] ==  __verifier_old_uint (allowance[from ][msg.sender] ) - value && success)  || (allowance[from ][msg.sender] ==  __verifier_old_uint (allowance[from ][msg.sender] ) && !success) || from  == msg.sender
    /// @notice  postcondition  allowance[from ][msg.sender]  <= __verifier_old_uint (allowance[from ][msg.sender] ) ||  from  == msg.sender
    /// @notice  emits  Transfer
    function transferFrom(address from, address to, uint value) external returns (bool success) {
        if (allowance[from][msg.sender] != uint(-1)) {
            allowance[from][msg.sender] = allowance[from][msg.sender].sub(value);
        }
        _transfer(from, to, value);
        return true;
    }

     /// @notice  emits  Approval
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external {
        require(deadline >= block.timestamp, 'UniswapV2: EXPIRED');
        // bytes32 digest = keccak256(
        //     abi.encodePacked(
        //         '\x19\x01',
        //         DOMAIN_SEPARATOR,
        //         keccak256(abi.encode(PERMIT_TYPEHASH, owner, spender, value, nonces[owner]++, deadline))
        //     )
        // );
        // address recoveredAddress = ecrecover(digest, v, r, s);
        // require(recoveredAddress != address(0) && recoveredAddress == owner, 'UniswapV2: INVALID_SIGNATURE');
        _approve(owner, spender, value);
    }

    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);
}