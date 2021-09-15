// SPDF-Licence-Identifier: UNLICENSED

pragma solidity ^0.8.0;


import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    mapping(address => uint) wavesDict;
    uint private seed;
    mapping(address => uint) public lastWavedAt;

    event NewWave(address indexed from, uint timestamp, string message);

    struct Wave{
        address waver;// the address of the person who waved
        string message;// the message the user sent
        uint timestamp;// the timestamp when the user waved
    }

    Wave[] waves;//to store the Waves received

    constructor() payable{
        console.log("Wiii i'm a super smart contract");
    }

    //this _message is the one our user send us from the frontend
    function wave(string memory _message) public {
        address senderAddrs;
        senderAddrs = msg.sender;
        
        //We need to make sure the current timestamp is at least 15 min biger than the last time we stored
        require(lastWavedAt[senderAddrs] + 15 minutes < block.timestamp,"Wait 15m");
        lastWavedAt[senderAddrs] = block.timestamp;

        wavesDict[senderAddrs]+=1;
        console.log("User has waved us %d times",wavesDict[senderAddrs]);
        totalWaves+=1;
        console.log("%s has waved with messg: %s!", senderAddrs, _message);

        waves.push(Wave(senderAddrs, _message, block.timestamp));

        //Generate a PSEUDO random number in the range 0-100
        uint randomNumber = (block.difficulty + block.timestamp + seed)%100;
        console.log("Random # generated: %s", randomNumber);

        //Set the generated random number as the seed for the next wave
        seed = randomNumber;

        if(randomNumber < 50){
            console.log("%s won!",senderAddrs);
            uint priceAmount = 0.0001 ether;
            require(priceAmount <= address(this).balance, "Trying to withdraw more money than the contract has");
            (bool success,) = senderAddrs.call{value: priceAmount}("");
            require(success, "Failed to withdraw money from contract.");    
        }

        // //google this
        emit NewWave(senderAddrs, block.timestamp, _message);
    }

    function getAllWaves() view public returns(Wave[] memory){
        return waves;
    }    

    function getTotalWaves() view public returns(uint){
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
}