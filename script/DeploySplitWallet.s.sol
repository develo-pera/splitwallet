// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {SplitWallet} from "../src/SplitWallet.sol";

contract DeploySplitWallet is Script {
    function run() external returns (SplitWallet) {
        vm.startBroadcast();
        SplitWallet splitWallet = new SplitWallet();
        vm.stopBroadcast();

        return splitWallet;
    }
}