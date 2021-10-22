pragma solidity 0.8.9; 

import "./SafeMath.sol";

contract NoOverflow{
    mapping(address=>uint) balance;
    function contribute() public payable{
        balance[msg.sender] = msg.value;
    }
    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }
    function batchSend(address[] memory recipients, uint value) public {
        //This line is CHANGED
         uint total = SafeMath.mul(recipients.length, value);
        //this require passes when total is 0 
        require(balance[msg.sender] >= total);
        //subtract from sender 
        balance[msg.sender] = SafeMath.sub(balance[msg.sender],total);
        //transfer
        for(uint a=0; a<recipients.length; a++){
            balance[recipients[a]] = SafeMath.add(balance[recipients[a]],value);
        }
    }
       
}
