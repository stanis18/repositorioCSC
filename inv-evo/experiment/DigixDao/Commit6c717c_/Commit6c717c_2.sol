pragma solidity ^0.5.0;
/// @notice  invariant  totalSupply  ==  __verifier_sum_uint(balances)
contract Commit6c717c_2 {

    mapping (address => uint256) public balances;
  mapping (address => mapping (address => uint256)) public allowed;
//   mapping (address => bool) seller;

 /// @return total amount of tokens
  uint256 public totalSupply;

//   address config;
//   address owner;
//   address dao;
//   address public badgeLedger;
//   bool locked;

//   constructor (address _config) public {
//     config = _config;
//     owner = msg.sender;
//     // address _initseller = ConfigInterface(_config).getConfigAddress("sale1:address");
//     // seller[_initseller] = true; 
//     // badgeLedger = new Badge(_config);
//     locked = false;
//   }

    constructor () public {
        balances[address(1)] = 2;
        balances[address(2)] = 2;
    }

  /// @notice postcondition  balances[_owner] == balance
  function balanceOf(address _owner) public returns (uint256 balance) {
    return balances[_owner];
  }
  

  /// @notice  postcondition ( ( balances[msg.sender] ==  __verifier_old_uint (balances[msg.sender] ) - _value  && msg.sender  != _to ) ||   ( balances[msg.sender] ==  __verifier_old_uint ( balances[msg.sender] ) && msg.sender  == _to ) &&  success )  || !success
  /// @notice  postcondition ( ( balances[_to] ==  __verifier_old_uint ( balances[_to] ) + _value  && msg.sender  != _to ) ||   ( balances[_to] ==  __verifier_old_uint ( balances[_to] ) && msg.sender  == _to ) &&  success )   || !success
  /// @notice  emits  Transfer 
  function transfer(address _to, uint256 _value) public returns (bool success) {
    if (balances[msg.sender] >= _value && _value > 0) {
      balances[msg.sender] -= _value;
      balances[_to] += _value;
      emit Transfer(msg.sender, _to, _value);
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  /// @notice  postcondition ( ( balances[_from] ==  __verifier_old_uint (balances[_from] ) - _value  &&  _from  != _to ) || ( balances[_from] ==  __verifier_old_uint ( balances[_from] ) &&  _from == _to ) &&  success ) || !success
  /// @notice  postcondition ( ( balances[_to] ==  __verifier_old_uint ( balances[_to] ) + _value  &&  _from  != _to ) || ( balances[_to] ==  __verifier_old_uint ( balances[_to] ) &&  _from  == _to ) &&  success ) || !success
  /// @notice  postcondition ( allowed[_from ][msg.sender] ==  __verifier_old_uint (allowed[_from ][msg.sender] ) - _value ) || ( allowed[_from ][msg.sender] ==  __verifier_old_uint (allowed[_from ][msg.sender] ) && !success) ||  _from  == msg.sender
  /// @notice  postcondition  allowed[_from ][msg.sender]  <= __verifier_old_uint (allowed[_from ][msg.sender] ) ||  _from  == msg.sender
  /// @notice  emits  Transfer
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
      balances[_to] += _value;
      balances[_from] -= _value;
      allowed[_from][msg.sender] -= _value;
      emit Transfer(_from, _to, _value);
      return true;
    } else {
      return false;
    }
  }

  /// @notice  postcondition (allowed[msg.sender ][ _spender] ==  _value  &&  success) || ( allowed[msg.sender ][ _spender] ==  __verifier_old_uint ( allowed[msg.sender ][ _spender] ) && !success )    
  /// @notice  emits  Approval
  function approve(address _spender, uint256 _value) public returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  /// @notice postcondition allowed[_owner][_spender] == remaining
  function allowance(address _owner, address _spender) public returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

//   function mint(address _owner, uint256 _amount) public ifSales returns (bool success) {
//     totalSupply += _amount;
//     balances[_owner] += _amount;
//     return true;
//   }

//   function mintBadge(address _owner, uint256 _amount) public ifSales returns (bool success) {
//     if (!Badge(badgeLedger).mint(_owner, _amount)) return false;
//     return true;
//   }

//   function registerDao(address _dao) public ifOwner returns (bool success) {
//     if (locked == true) return false;
//     dao = _dao;
//     locked = true;
//     return true;
//   }

//   function registerSeller(address _tokensales) public ifDao returns (bool success) {
//     seller[_tokensales] = true;
//     return true;
//   }

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}