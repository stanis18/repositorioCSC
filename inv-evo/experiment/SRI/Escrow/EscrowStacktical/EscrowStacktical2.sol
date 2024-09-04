pragma solidity >=0.5.0;

contract Escrow {

    mapping(address=>uint) internal deposits ;
 

  /** 	@notice precondition payee != address(0)
	    @notice precondition  address(this) != msg.sender
		@notice precondition payee != address(this)
	    @notice precondition  deposits[payee] + msg.value >= deposits[payee]
	    @notice precondition  address(this).balance + msg.value >= address(this).balance
     	@notice postcondition deposits[payee] == __verifier_old_uint(deposits[payee]) + msg.value
	    @notice postcondition address(this).balance == __verifier_old_uint(address(this).balance) + msg.value */

    function deposit(address payee) public payable {
    	require(payee != address(0));
		require(msg.value > 0);
	    deposits[payee] = deposits[payee] + msg.value;

    }


    /** @notice precondition payee != address(0)
        @notice precondition  deposits[payee] > 0
		@notice precondition  payee != address(this)
        @notice postcondition deposits[payee] == 0
	    @notice postcondition address(this).balance == __verifier_old_uint(address(this).balance) - __verifier_old_uint(deposits[payee]) */

    function withdraw(address payable payee) public {
    	require(payee != address(0));
		require(address(this).balance >= deposits[payee]);
		//uint amount = deposits[payee];
		
	    payee.transfer(deposits[payee]);
		deposits[payee] = 0;

    }

	/** @notice precondition payee != address(0)
	 */
	function depositsOf(address payee) public view returns(uint) {
        return deposits[payee];
    }

}