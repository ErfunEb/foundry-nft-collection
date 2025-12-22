// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {stdJson} from "forge-std/StdJson.sol";
import {Script} from "forge-std/Script.sol";
import {BasicNft} from "src/BasicNft.sol";

contract MintBasicNft is Script {
    using stdJson for string;
    string constant PUG =
        "https://bafybeifkbpoxnjce54toeiofyk2uwzpraemepkfdnptdqrshjcguywm3y4.ipfs.dweb.link?filename=pug.json";

    function run() external {
        string memory latestJsonBuild = vm.readFile(
            "script/deployments/basicNft.json"
        );

        string memory deployedAddressHex = latestJsonBuild.readString(
            ".transactions[0].contractAddress"
        );

        address deployedContract = vm.parseAddress(deployedAddressHex);

        mintNftOnContract(deployedContract);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}
