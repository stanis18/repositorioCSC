// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;


/// @notice  invariant  totalSupply  ==  __verifier_sum_uint(users[addr].balance)
contract TokenSpecification {

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
  
  }
  
  /// @notice postcondition  users[_owner].balance == balance
  function balanceOf(address _owner) public returns (uint256 balance)  {
  }

  function badgesOf(address _owner) public returns (uint256 badge)  {
  }
  
  /// @notice  postcondition ( ( users[msg.sender].balance ==  __verifier_old_uint (users[msg.sender].balance ) - _value  && msg.sender  != _to ) ||   ( users[msg.sender].balance ==  __verifier_old_uint ( users[msg.sender].balance ) && msg.sender  == _to ) &&  success )  || !success
  /// @notice  postcondition ( ( users[_to].balance ==  __verifier_old_uint ( users[_to].balance ) + _value  && msg.sender  != _to ) ||   ( users[_to].balance ==  __verifier_old_uint ( users[_to].balance ) && msg.sender  == _to ) &&  success )   || !success
  /// @notice  emits  Transfer 
  function transfer(address _to, uint256 _value) public returns (bool success)  {
 
  }

   /// @notice  emits  Transfer 
  function sendBadge(address _to, uint256 _value) public returns (bool success)  {

  }

  /// @notice  postcondition ( ( users[_from].balance ==  __verifier_old_uint (users[_from].balance ) - _value  &&  _from  != _to ) || ( users[_from].balance ==  __verifier_old_uint ( users[_from].balance ) &&  _from == _to ) &&  success ) || !success
  /// @notice  postcondition ( ( users[_to].balance ==  __verifier_old_uint ( users[_to].balance ) + _value  &&  _from  != _to ) || ( users[_to].balance ==  __verifier_old_uint ( users[_to].balance ) &&  _from  == _to ) &&  success ) || !success
  /// @notice  postcondition ( allowed[_from ][msg.sender] ==  __verifier_old_uint (allowed[_from ][msg.sender] ) - _value ) || ( allowed[_from ][msg.sender] ==  __verifier_old_uint (allowed[_from ][msg.sender] ) && !success) ||  _from  == msg.sender
  /// @notice  postcondition  allowed[_from ][msg.sender]  <= __verifier_old_uint (allowed[_from ][msg.sender] ) ||  _from  == msg.sender
  /// @notice  emits  Transfer
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
   
  }

  /// @notice  postcondition (allowed[msg.sender ][ _spender] ==  _value  &&  success) || ( allowed[msg.sender ][ _spender] ==  __verifier_old_uint ( allowed[msg.sender ][ _spender] ) && !success )    
  /// @notice  emits  Approval
  function approve(address _spender, uint256 _value) public returns (bool success) {

  }

  /// @notice postcondition allowed[_owner][_spender] == remaining
  function allowance(address _owner, address _spender) public  returns (uint256 remaining) {
  }

  function mint(address _owner, uint256 _amount) ifSales public returns (bool success) {

  }

  function mintBadge(address _owner, uint256 _amount) ifSales public returns (bool success) {
  
  }

  function registerDao(address _dao) ifOwner public returns (bool success) {
    
  }

  function registerSeller(address _tokensales) ifDao public returns (bool success) {
  }

}
