pragma solidity ^0.8.0;

contract PayInvestors {
    address bank;
    uint bankBalance;
    address payable[] investorWallets;
    mapping(address => uint) balances;
    
    constructor() payable {
        bank = msg.sender;
        bankBalance = msg.value;
    }
    
    function allocateToInvestor(address payable investor, uint amount) public {
        investorWallets.push(investor);
        balances[investor] = amount;
    }
    
    function payInvestors() payable public {
        for (uint i=0; i < investorWallets.length; i++) {
            bankBalance -= balances[investorWallets[i]];
            investorWallets[i].transfer(balances[investorWallets[i]]);  // TODO - use .call.value(...)("") instead due to variable gas costs
        }
    }
    
    function checkInvestor(address investor) public view returns(uint) {
        return balances[investor];
    }
    
    function checkInvestorCount() public view returns(uint) {
        return investorWallets.length;
    }
    
    function getBankBalance() public view returns (uint) {
        return bankBalance;
    }
    
    function transfer1EthTo(address payable investor) payable public {
        investor.transfer(10000000000);  // TODO - use .call.value(...)("") instead due to variable gas costs
    }
}