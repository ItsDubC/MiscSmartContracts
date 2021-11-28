pragma solidity ^0.8.0;

contract Will {
    address owner;
    uint fortune;
    bool isDeceased;
    address payable[] familyWallets;
    mapping (address => uint) inheritance;
    
    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }
    
    // create modifier so the only person who can call contract is the owner
    modifier callerMustBeOwner {
        require(msg.sender == owner);
        _;
    }
    
    // create modifier so we only allocate funds if owner is deceased
    modifier ownerMustBeDeceased {
        require(isDeceased == true);
        _;
    }
    
    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public {
        // add wallets to familyWallets
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }
    
    //pay each family member based on wallet address
    function payout() private ownerMustBeDeceased {
        for (uint i = 0; i < familyWallets.length; i++) {
            // transfer funds fron contract address to receiver address
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }
    
    // simulates Oracle switching status
    function setDeceased() public callerMustBeOwner {
        isDeceased = true;
        payout();
    }
}
