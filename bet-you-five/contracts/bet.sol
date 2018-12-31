pragma solidity ^0.4.25;
pragma experimental "v0.5.0";

contract BetContract {
    
    //creator puts amount. 0.05, 0.5, 5eth, etc. 
    //specifies secret? time expire, judge addr
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
    
    function createBet() public {}
    
    function acceptBet() public {
        
    }
    
    function judgeBet() public {
        
    }
    
    function refundBet() private {
        
    }
    
    function kill() public constant{
        //destructor
        // selfdestruct()
    }
    
    
    
}