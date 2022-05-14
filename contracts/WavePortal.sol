//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint waveCount;
    uint256 private seed;

    mapping(address=> uint256) public lastWavedAt;

    event NewWave(address indexed from,uint256 timestamp,string message);

    struct Wave{
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    constructor() payable{
        console.log("I Am A SMART CONTRACT.POG");
        seed = (block.timestamp * block.difficulty) % 100;
    }

    function waveAtMe(string memory _message) public {
        require(lastWavedAt[msg.sender]+ 1 minutes < block.timestamp,"wait for 1 minute");
        lastWavedAt[msg.sender] = block.timestamp;
        waveCount = waveCount + 1;
        console.log("%s waved at me",msg.sender);
        console.log("%s waved w/ message %s", msg.sender, _message);
        waves.push(Wave(msg.sender,_message,block.timestamp));
       
        seed = (block.timestamp* block.difficulty) % 100;
        console.log("Random # generated: %d", seed);
        // require(seed + 15mins < block.timestamp,"Wait for 15 minues");
        if(seed <= 50){
            uint256 priceAmount = 0.001 ether;
            require(priceAmount <= address(this).balance,"Trying to withdraw more than the contract has");
            (bool success,)= (msg.sender).call{value:priceAmount}("");
            require(success,"Failed to withdraw money from contract");
        }
        emit NewWave(msg.sender,block.timestamp,_message);

    }

    function getAllWaves() public  view returns(Wave[] memory){
        return waves;
    }

    function getMyWaves() public view returns(uint){
        console.log("We have %d total waves :)", waveCount);
        return waveCount;
    }

}
