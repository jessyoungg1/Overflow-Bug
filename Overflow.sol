pragma solidity 0.8.9;

contract Overflow{
    mapping(address=>uint) balance;
    function contribute() public payable{
        balance[msg.sender] = msg.value;
    }
    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }
    function batchSend(address[] memory recipients, uint value) public {
        //This line is where the vulnerability is - it overflows 
        uint total = recipients.length * value; //this has an upper limit of 256 bits 
        //this require passes when total is 0 
        require(balance[msg.sender] >= total);
        //subtract from sender 
        balance[msg.sender] = balance[msg.sender]-total;
        //transfer
        for(uint a=0; a<recipients.length; a++){
            balance[recipients[a]] += value;
        }
    }
}

