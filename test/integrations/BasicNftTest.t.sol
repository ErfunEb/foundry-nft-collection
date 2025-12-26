// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public user = makeAddr("user");
    string constant PUG =
        "https://bafybeifkbpoxnjce54toeiofyk2uwzpraemepkfdnptdqrshjcguywm3y4.ipfs.dweb.link?filename=pug.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        bytes32 nftHash = keccak256(abi.encodePacked(basicNft.name()));
        bytes32 expectedHash = keccak256(abi.encodePacked("Dogie"));
        assert(nftHash == expectedHash);
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(user);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(user) == 1);
        assert(
            keccak256(abi.encodePacked(PUG)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
