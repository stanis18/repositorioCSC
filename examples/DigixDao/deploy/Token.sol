// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;


contract Token  {

  struct User {
    bool locked;
    uint256 balance;
    uint256 badges;
    mapping (address => uint256) allowed;
  }

  mapping (address => User) users;
  mapping (address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;
  mapping (address => bool) seller;

  address config;
  address owner;
  address dao;
  bool locked;


  uint256 public totalSupply;
  uint256 public totalBadges;

  modifier noEther() {
    if (msg.value > 0) revert();
    _;
  }

  modifier ifSales() {
    if (!seller[msg.sender]) revert(); 
    _; 
  }

  modifier ifOwner() {
    if (msg.sender != owner) revert();
    _;
  }

  modifier ifDao() {
    if (msg.sender != dao) revert();
    _;
  }

  constructor (address _config) public {
    config = _config;
    owner = msg.sender;
    // address _initseller = ConfigInterface(_config).getConfigAddress("sale1:address");
    // seller[_initseller] = true; 
    // locked = false;
  }
  
  function balanceOf(address _owner) public returns (uint256 balance)  {
    return users[_owner].balance;
  }

  function badgesOf(address _owner) public returns (uint256 badge)  {
    return users[_owner].badges;
  }

  
  function transfer(address _to, uint256 _value) public returns (bool success)  {
    if (users[msg.sender].balance >= _value && _value > 0) {
      users[msg.sender].balance -= _value;
      users[_to].balance += _value;
      emit Transfer(msg.sender, _to, _value);
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  function sendBadge(address _to, uint256 _value) public returns (bool success)  {
    if (users[msg.sender].badges >= _value && _value > 0) {
      users[msg.sender].badges -= _value;
      users[_to].badges += _value;
      emit Transfer(msg.sender, _to, _value);
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    if (users[_from].balance >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
      users[_to].balance += _value;
      users[_from].balance -= _value;
      allowed[_from][msg.sender] -= _value;
      emit Transfer(_from, _to, _value);
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  function approve(address _spender, uint256 _value) public returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) public  returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

  function mint(address _owner, uint256 _amount) ifSales public returns (bool success) {
    totalSupply += _amount;
    users[_owner].balance += _amount;
    return true;
  }

  function mintBadge(address _owner, uint256 _amount) ifSales public returns (bool success) {
    totalBadges += _amount;
    users[_owner].badges += _amount;
    return true;
  }

  function registerDao(address _dao) ifOwner public returns (bool success) {
    if (locked == true) return false;
    dao = _dao;
    locked = true;
    return true;
  }

  function registerSeller(address _tokensales) ifDao public returns (bool success) {
    seller[_tokensales] = true;
  }

  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event SendBadge(address indexed _from, address indexed _to, uint256 _amount);
}
