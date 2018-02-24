pragma solidity 0.4.19;


contract Betting {
    /* Constructor function, where owner and outcomes are set */
    function Betting(uint[] _outcomes) public {
        owner = tx.origin;
        uint[] memory outcomes = _outcomes;
    }

    /* Fallback function */
    function() public payable {
        revert();
    }

    /* Standard state variables */
    address public owner;
    address public gamblerA;
    address public gamblerB;
    address public oracle;
    uint public count = 0;

    /* Structs are custom data structures with self-defined parameters */
    struct Bet {
        uint outcome;
        uint amount;
        bool initialized;
    }

    /* Keep track of every gambler's bet */
    mapping (address => Bet) bets;
    /* Keep track of every player's winnings (if any) */
    mapping (address => uint) winnings;
    /* Keep track of all outcomes (maps index to numerical outcome) */
    mapping (uint => uint) public outcomes;

    /* Add any events you think are necessary */
    event BetMade(address gambler);
    event BetClosed();

    /* Uh Oh, what are these? */
    modifier ownerOnly() {_;}
    modifier oracleOnly() {_;}
    modifier outcomeExists(uint outcome) {_;}

    /* Owner chooses their trusted Oracle */
    function chooseOracle(address _oracle) public ownerOnly() returns (address) {
        return _oracle;
    }

    /* Gamblers place their bets, preferably after calling checkOutcomes */
    function makeBet(uint _outcome, uint _amount) public payable returns (bool) {
        if (count == 2) {
            return false;
        }
        if (bets[tx.origin].initialized == false) {
            bets[tx.origin].outcome = _outcome;
            bets[tx.origin].initialized = true;
            bets[tx.origin].amount = _amount;
            count = count + 1;
            return true;
        }
        else {
            return false;
        }
    }

    /* The oracle chooses which outcome wins */
    function makeDecision(uint _outcome) public oracleOnly() outcomeExists(_outcome) {
        if (bets[gamblerA].outcome == _outcome && bets[gamblerB].outcome == _outcome) {
            winnings[gamblerA] = bets[gamblerA].amount;
            winnings[gamblerB] = bets[gamblerB].amount;
        }
        if (bets[gamblerA].outcome != _outcome && bets[gamblerB].outcome == _outcome) {
            winnings[gamblerA] = 0;
            winnings[gamblerB] = bets[gamblerA].amount + bets[gamblerB].amount;
        }
        if (bets[gamblerA].outcome == _outcome && bets[gamblerB].outcome != _outcome) {
            winnings[gamblerA] = bets[gamblerA].amount + bets[gamblerB].amount;
            winnings[gamblerB] = 0;
        }
        else {
            winnings[gamblerA] = 0;
            winnings[gamblerB] = 0;
            winnings[oracle] = bets[gamblerA].amount + bets[gamblerB].amount;
        }
    }

    /* Allow anyone to withdraw their winnings safely (if they have enough) */
    function withdraw(uint withdrawAmount) public returns (uint) {
        bool ret = tx.origin.send(winnings[tx.origin]);
        return winnings[tx.origin];
    }

    /* Allow anyone to check the outcomes they can bet on */
    function checkOutcomes(uint outcome) public view returns (uint) {
        return outcomes[outcome];
    }

    /* Allow anyone to check if they won any bets */
    function checkWinnings() public view returns(uint) {
        return winnings[tx.origin];
    }

    /* Call delete() to reset certain state variables. Which ones? That's up to you to decide */
    function contractReset() public ownerOnly() {
    }
}
