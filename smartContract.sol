pragma solidity ^0.4.18;

contract Target {
 
 
  uint256 PI = 314159265358979323846264338327950288419716939937510;
  uint256 E = 271;
  
  struct Check_ans {

    address addr;
    bool guess_rand;
    bool guess_pwd;
  }
  Check_ans Hacker;
  
  bytes32 private PWD;
  
  function Target(bytes32 password) public {
    PWD = password;
  }
  
  
  modifier is_Regist {
    
    if (Hacker.addr != 0x0000000000000000000000000000000000000000)
      revert();
    _;
  }
  
  
  modifier is_Challenger {
    
    if (Hacker.addr != tx.origin)
      revert();
    _;
  }
  
  
  function Register() public is_Regist returns(bool){
      
      Hacker.addr = msg.sender;
      return true;
  }
  
  
  function Guess_random(uint256 _guess) public is_Challenger returns(bool) {
    
    uint256 Value1 = uint256(block.blockhash(block.number-1));
    uint256 Value2 = uint256(block.number);
    uint256 random_num = uint256((uint256(Value1) / PI) + (uint256(Value2) / E));
    
    if (random_num == _guess) {
      Hacker.guess_rand = true;
      return true;
    }

  }
  
  
  function Guess_password(bytes32 _guess) public is_Challenger returns(bool) {
    
    if (PWD == _guess) {
      Hacker.guess_pwd = true;
      return true;
    }

  }
  
  
  function Validate() public view returns(address, bool, bool){
      
      return (Hacker.addr, Hacker.guess_rand, Hacker.guess_pwd);
  }
  
}
