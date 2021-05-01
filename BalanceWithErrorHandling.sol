pragma solidity >=0.4.22 <0.6.0;


// ERC20 contract interface
contract TokenBalance {
  function balanceOf(address) public view returns (uint);
}

contract BalanceChecker {
  /* Fallback function, don't accept any ETH */
  function() public payable {
    revert("BalanceChecker does not accept payments");
  }

  /*
    Check the token balance of a wallet in a token contract
    Returns the balance of the token for user. Avoids possible errors:
      - return 0 on non-contract address 
      - returns 0 if the contract doesn't implement balanceOf
  */
  function tokenBalance(address user, address token) public view returns (uint) {
    // check if token is actually a contract
    uint256 tokenCode;
    assembly { tokenCode := extcodesize(token) } // contract code size
  
    // is it a contract and does it implement balanceOf 
    if (tokenCode > 0 && token.call(bytes4(0x70a08231), user)) {  
      return TokenBalance(token).balanceOf(user);
    } else {
      return 0;
    }
  }

 
}
