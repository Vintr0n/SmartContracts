pragma solidity >=0.4.22 <0.6.0;  

contract TokenBalance
{
function balanceOf(address) public view returns (uint);    
}

contract BalanceChecker {


 function tokenBalance(address user, address token) public view returns (uint) {
  
      return TokenBalance(token).balanceOf(user);
   
  }
 
}
