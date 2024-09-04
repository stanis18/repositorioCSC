pragma solidity ^0.5.0;

/**
 * @notice simulation  __verifier_eq(Escrow_Stacktical.deposits, Escrow.deposits)
 */
contract Escrow_Stacktical {

    mapping(address => uint) internal deposits;

    /**
      * @dev Stores the sent amount as credit to be withdrawn.
      * @param _payee The destination address of the funds.
      */
    function deposit(address _payee) public payable {
        uint256 amount = msg.value;
       deposits[_payee] = deposits[_payee] + amount;

    }

    /**
      * @dev Withdraw accumulated balance for a payee.
      * @param _payee The address whose funds will be withdrawn and transferred to.
      * @return Amount withdrawn
      */
    function withdraw(address payable _payee) public  {
        uint256 payment = deposits[_payee];

        require(address(this).balance >= payment);

        deposits[_payee] = 0;

        _payee.transfer(payment);
    }

    /**
      * @dev Withdraws the wallet's funds.
      * @param _wallet address the funds will be transferred to.
      
    function beneficiaryWithdraw(address _wallet) public onlyOwner {
        uint256 _amount = address(this).balance;
        
        _wallet.transfer(_amount);

        emit Withdrawn(_wallet, _amount);
    }*/

    /**
      * @dev Returns the deposited amount of the given address.
      * @param _payee address of the payee of which to return the deposted amount.
      * @return Deposited amount by the address given as argument.
      
    function depositsOf(address _payee) public view returns(uint) {
        return deposits[_payee];
    }*/

    function depositsOf(address _payee) public view returns(uint) {
        return deposits[_payee];
    }
}