// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract BasicNft is ERC721Upgradeable {
    uint256 private tokenCounter;
    mapping(uint256 => string) private tokenIdToUri;

    constructor() initializer {
        __ERC721_init("Dogie", "DOG");
        tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public {
        tokenIdToUri[tokenCounter] = tokenUri;
        _safeMint(msg.sender, tokenCounter);
        tokenCounter++;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return tokenIdToUri[tokenId];
    }
}
