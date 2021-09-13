// SPDF-Licence-Identifier: UNLICENSED

pragma solidity ^0.8.0;


import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    mapping(address => uint) wavesDict;

    constructor(){
        console.log("Wiii i'm a super smart contract");
    }

    function wave() public {
        address senderAddrs;
        senderAddrs = msg.sender;
        wavesDict[senderAddrs]+=1;
        console.log("User has waved us %d times",wavesDict[senderAddrs]);
        totalWaves+=1;
        console.log("%s has waved!", senderAddrs);
    }

    function getTotalWaves() view public returns(uint){
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
}