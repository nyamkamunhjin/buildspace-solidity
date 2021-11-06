// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 public totalWaves;
    address[] private wavers;


    constructor() {
        console.log("Yo, i'm waving bros.");
    }

    function wave() public {
        totalWaves += 1;
        wavers.push(msg.sender);
        console.log("%s has waved!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getTotalWavedAddresses() public view returns (address[] memory) {
        return wavers;
    }
}
