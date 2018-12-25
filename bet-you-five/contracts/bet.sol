pragma solidity ^0.4.25;

contract Bet {
    
    //creator specifies amount. 0.05, 0.5, 5eth, etc. 
    //specifies secret? (so only those who know this can accept) time expire, judge addr
    //only 1 other can accept. 
    
    //other must accept in 1 day or ETH gets returned
    //if judge doesnt decide, money gets returned
    //if decided, all escrow gets sent to one party.
    
    uint256 callerResponseExpireDate;
    uint256 judgeResponseExpireDate;
    
    struct Bet {
        address raiser;
        address caller;
        address judge;
        uint256 amount;
        uint256 expireDate;
    }
    
    
}