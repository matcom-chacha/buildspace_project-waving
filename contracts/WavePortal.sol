// SPDF-Licence-Identifier: UNLICENSED

pragma solidity ^0.8.0;


import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    
    constructor(){
        console.log("Wiii i'm a super smart contract");
    }

    function wave() public {
        totalWaves +=1;
        console.log("%s has waved!", msg.sender);
    }

    function getTotalWaves() view public returns(uint){
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
}