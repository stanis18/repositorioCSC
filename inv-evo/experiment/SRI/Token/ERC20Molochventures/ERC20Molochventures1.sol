pragma solidity >=0.5.0;

// Link to contract source code:
// https://github.com/MolochVentures/moloch/blob/master/contracts/Token.sol


/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md
 * Originally based on code by FirstBlood:
 * https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 *
 * This implementation emits additional Approval events, allowing applications to reconstruct the allowance status for
 * all accounts just by listening to said events. Note that this isn't required by the specification, and other
 * compliant implementations may not do it.
 */


// TODO add notice simulation  Token._totalSupply ==  __verifier_sum_uint(ERC20.balances)



 /**
 * @notice simulation  __verifier_eq(Token._balances, ERC20.balances)
 * @notice simulation __verifier_eq(Token._allowed, ERC20.allowances)
 */
contract Token {
    //using SafeMath for uint;

    mapping (address => uint) public _balances;

    mapping (address => mapping (address => uint)) public _allowed;

    uint public _totalSupply;


    constructor () public {
        _balances[address(1)] = 2;
        _balances[address(2)] = 2;
    }

    /**
     * @dev Total number of tokens in existence
     */
    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    /**
     * @dev Gets the balance of the specified address.
     * @param owner The address to query the balance of.
     * @return An uint representing the amount owned by the passed address.
     */
    function balance(address owner) public view returns (uint) {
        return _balances[owner];
    }

    /**
     * @dev Function to check the amount of tokens that an owner allowed to a spender.
     * @param owner address The address which owns the funds.
     * @param spender address The address which will spend the funds.
     * @return A uint specifying the amount of tokens still available for the spender.
     */
    function allowance(address owner, address spender) public view returns (uint) {
        return _allowed[owner][spender];
    }



    /**
     * @dev Transfer token for a specified address
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
        @notice modifies _balances[msg.sender]
        @notice modifies _balances[to]
     */
    function transfer(address to, uint value) public {
        _transfer(msg.sender, to, value);
    }

    /**
     * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
     * Beware that changing an allowance with this method brings the risk that someone may use both the old
     * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
     * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     * @param spender The address which will spend the funds.
     * @param value The amount of tokens to be spent.
      @notice modifies _allowed[msg.sender]
     */
    function approve(address spender, uint value) public {
        _approve(msg.sender, spender, value);
    }

    /**
     * @dev Transfer tokens from one address to another.
     * Note that while this function emits an Approval event, this is not required as per the specification,
     * and other compliant implementations may not emit the event.
     * @param from address The address which you want to send tokens from
     * @param to address The address which you want to transfer to
     * @param value uint the amount of tokens to be transferred
        @notice modifies _balances[to]
        @notice modifies _balances[from]
        @notice modifies _allowed[from]
     */
    function transferFrom(address from, address to, uint value) public {
         require(_allowed[from][msg.sender] - value >= 0);
        _transfer(from, to, value);
        _approve(from, msg.sender, _allowed[from][msg.sender] - value);
    }

    /**
     * @dev Increase the amount of tokens that an owner allowed to a spender.
     * approve should be called when allowed_[_spender] == 0. To increment
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * Emits an Approval event.
     * @param spender The address which will spend the funds.
     * @param addedValue The amount of tokens to increase the allowance by.
       @notice modifies _allowed[msg.sender]
     */
    function increaseAllowance(address spender, uint addedValue) public {
        _approve(msg.sender, spender, _allowed[msg.sender][spender] + addedValue);
    }

    /**
     * @dev Decrease the amount of tokens that an owner allowed to a spender.
     * approve should be called when allowed_[_spender] == 0. To decrement
     * allowed value is better to use this function to avoid 2 calls (and wait until
     * the first transaction is mined)
     * From MonolithDAO Token.sol
     * Emits an Approval event.
     * @param spender The address which will spend the funds.
     * @param subtractedValue The amount of tokens to decrease the allowance by.
       @notice modifies _allowed[msg.sender]
     */
    function decreaseAllowance(address spender, uint subtractedValue) public {
        require(_allowed[msg.sender][spender] - subtractedValue >= 0);
        _approve(msg.sender, spender, _allowed[msg.sender][spender] - subtractedValue);
    }

    /**
     * @dev Transfer token for a specified addresses
     * @param from The address to transfer from.
     * @param to The address to transfer to.
     * @param value The amount to be transferred.
       @notice modifies _balances[from]
       @notice modifies _balances[to]
     */
    function _transfer(address from, address to, uint value) internal {
        require(to != address(0));
        require(_balances[from] >= value);

        _balances[from] = _balances[from] - value;
        _balances[to] = _balances[to] + value;
        //emit Transfer(from, to, value);
    }

    /**
     * @dev Internal function that mints an amount of the token and assigns it to
     * an account. This encapsulates the modification of balances such that the
     * proper events are emitted.
     * @param to The account that will receive the created tokens.
     * @param val The amount that will be created.
     @notice modifies _balances[to]
     @notice modifies _totalSupply
     */
    function mint(address to, uint val) internal {
        require(to != address(0));

        _totalSupply = _totalSupply + val;
        _balances[to] = _balances[to] + val;
        //emit Transfer(address(0), account, value);
    }

    /**
     * @dev Internal function that burns an amount of the token of a given
     * account.
     * @param from The account whose tokens will be burnt.
     * @param val The amount that will be burnt.
      @notice modifies _balances[from]
      @notice modifies _totalSupply
     */
    function burn(address from, uint val) internal {
        require(from != address(0));
        require(_balances[from] >= val);

        _totalSupply = _totalSupply - val;
        _balances[from] = _balances[from] - val;
        //emit Transfer(account, address(0), value);
    }

    /**
     * @dev Approve an address to spend another addresses' tokens.
     * @param owner The address that owns the tokens.
     * @param spender The address that will spend the tokens.
     * @param value The number of tokens that can be spent.
     @notice modifies _allowed[owner]
     */
    function _approve(address owner, address spender, uint value) internal {
        require(spender != address(0));
        require(owner != address(0));

        _allowed[owner][spender] = value;
        //emit Approval(owner, spender, value);
    }

    /**
     * @dev Internal function that burns an amount of the token of a given
     * account, deducting from the sender's allowance for said account. Uses the
     * internal burn function.
     * Emits an Approval event (reflecting the reduced allowance).
     * @param account The account whose tokens will be burnt.
     * @param value The amount that will be burnt.
     */
    function _burnFrom(address account, uint value) internal {
        burn(account, value);
        _approve(account, msg.sender, _allowed[account][msg.sender] - value);
    }
}
