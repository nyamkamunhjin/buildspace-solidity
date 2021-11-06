// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 public totalWaves;
    
    event NewWave(address indexed from, uint256 timestamp, string message, string color);

    struct Wave {
        address waver;
        string message;
        string color;
        uint256 timestamp;
    }

    Wave[] public waves;

    constructor() payable {
        console.log("Yo, i'm waving bros.");
    }

    function wave(string memory _message, string memory _color) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);

        waves.push(Wave({
            waver: msg.sender,
            message: _message,
            color: _color,
            timestamp: block.timestamp
        }));

        emit NewWave(msg.sender, block.timestamp, _message, _color);

        uint256 prizeAmount = 0.0001 ether;

        require(prizeAmount <= address(this).balance, "You're not allowed to withdraw more money than this contract has.");

        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }
}
