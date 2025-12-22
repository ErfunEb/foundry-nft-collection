// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 private tokenCounter;
    mapping(uint256 => string) private tokenIdToUri;

    constructor() ERC721("Dogie", "DOG") {
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
