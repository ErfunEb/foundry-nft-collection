// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft_NotOwner();

    uint256 private tokenCounter;
    string private sadSvgImageUri;
    string private happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private tokenIdToMood;

    modifier onlyApprovedOrOwner(uint256 tokenId) {
        _checkApprovedOrOwner(tokenId);
        _;
    }

    function _checkApprovedOrOwner(uint256 tokenId) internal view {
        address owner = ownerOf(tokenId);

        if (
            msg.sender != owner &&
            getApproved(tokenId) != msg.sender &&
            !isApprovedForAll(owner, msg.sender)
        ) {
            revert MoodNft_NotOwner();
        }
    }

    constructor(
        string memory _sadSvgImageUri,
        string memory _happySvgImageUri
    ) ERC721("Mood NFT", "MN") {
        tokenCounter = 0;
        sadSvgImageUri = _sadSvgImageUri;
        happySvgImageUri = _happySvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, tokenCounter);
        tokenIdToMood[tokenCounter] = Mood.HAPPY;
        tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = happySvgImageUri;
        } else {
            imageURI = sadSvgImageUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                "{",
                                '"name": "',
                                name(),
                                '", "description": "An NFT that reflects the owners mood.", ',
                                '"attributes": [{"traint_type": "moodiness", "value": 100}], "image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function flipMood(uint256 tokenId) public onlyApprovedOrOwner(tokenId) {
        if (tokenIdToMood[tokenId] == Mood.HAPPY) {
            tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }
}
