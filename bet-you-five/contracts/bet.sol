pragma solidity ^0.4.25;
pragma experimental "v0.5.0";

import "./SafeMath.sol";
import "./Secondary.sol";

contract BetContract is Secondary  {
    
    using SafeMath for uint256;
    
    //creator sends eth, and sets expiredate and judge addr
    
    //other must accept in 1 day or before expireDate. Otherwise creator's ETH gets returned
    //if judge doesnt decide, money gets returned to each party
    //if decided, all escrow gets sent to winning party

    event Deposited(address indexed payee, uint256 weiAmount);
    event Withdrawn(address indexed payee, uint256 weiAmount);
    
    uint256 callerResponseExpireDate;
    uint256 judgeResponseExpireDate;
    enum WinningStatus { Pending, Creator, Caller }
    // Bet[] public bets;
    
    struct Bet {
        address raiser;
        address caller;
        address judge;
        uint256 amount;
        uint256 expireDate;
        WinningStatus status;
    }
    
    //creator may only have one bet at a time
    mapping(address => Bet) public bets;
    mapping(address => uint256) private _deposits;
    
    function createBet(address judge, uint256 amount, uint256 expireDate) public {
        //if creator hasn't created a bet yet:
        //if money received
        bets[msg.sender] = Bet(msg.sender, 0, judge, amount, expireDate, WinningStatus.Pending);
        //put into escrow
    }
    
    function acceptBet(address creatorBetAddress) public {
        //if bet exists, accept bet
        bets[creatorBetAddress].caller = msg.sender;
        //put matching amount into escrow
    }
    
    function judgeBet(address creatorBetAddress, bool creatorIsWinner) public {
        //if bet exists and the judge is calling this, declare winner 
        if( bets[creatorBetAddress].judge == msg.sender){
            if(creatorIsWinner){
                bets[creatorBetAddress].status = WinningStatus.Creator;
            }else{
                bets[creatorBetAddress].status = WinningStatus.Caller;
            }
        }
        //release escrow accordingly
    }
    
    function refundBet() private {
        
    }
    
    function kill() public {
        //destructor
        // selfdestruct()
    }
    
    function depositsOf(address payee) public view returns (uint256) {
        return _deposits[payee];
    }

    /**
    * @dev Stores the sent amount as credit to be withdrawn.
    * @param payee The destination address of the funds.
    */
    function deposit(address payee) public onlyPrimary payable {
        uint256 amount = msg.value;
        _deposits[payee] = _deposits[payee].add(amount);

        emit Deposited(payee, amount);
    }

    /**
    * @dev Withdraw accumulated balance for a payee.
    * @param payee The address whose funds will be withdrawn and transferred to.
    */
    function withdraw(address payee) public onlyPrimary {
        uint256 payment = _deposits[payee];

        _deposits[payee] = 0;

        payee.transfer(payment);

        emit Withdrawn(payee, payment);
    }
    
}