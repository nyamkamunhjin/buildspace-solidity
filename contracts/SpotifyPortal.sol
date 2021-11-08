// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract SpotifyPortal {
    uint256 public totalSpotifyMessages;
    
    event NewSpotifyMessage(address indexed from, uint256 timestamp, string message, string url);

    struct SpotifyMessage {
        address sender;
        string message;
        string url;
        uint256 timestamp;
    }

    SpotifyMessage[] public spotifyMessages;

    constructor() payable {
        console.log("Spotify messages contract.");
    }

    function sendSpotifyUrl(string memory _message, string memory _url) public {
        totalSpotifyMessages += 1;
        console.log("%s has waved!", msg.sender);

        spotifyMessages.push(SpotifyMessage({
            sender: msg.sender,
            message: _message,
            url: _url,
            timestamp: block.timestamp
        }));

        emit NewSpotifyMessage(msg.sender, block.timestamp, _message, _url);

        uint256 prizeAmount = 0.0001 ether;

        require(prizeAmount <= address(this).balance, "You're not allowed to withdraw more money than this contract has.");

        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
    }

    function getTotalSpotifyMessages() public view returns (uint256) {
        return totalSpotifyMessages;
    }

    function getAllSpotifyMessages() public view returns (SpotifyMessage[] memory) {
        return spotifyMessages;
    }

   
}
