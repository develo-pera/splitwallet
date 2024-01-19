// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {SplitWallet} from "../src/SplitWallet.sol";

contract DeploySplitWallet is Script {
    function run() external returns (SplitWallet splitWallet, HelperConfig helperConfig) {
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!
        address ghoToken = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        SplitWallet splitWallet = new SplitWallet(ghoToken);
        vm.stopBroadcast();

        return (splitWallet, helperConfig);
    }
}