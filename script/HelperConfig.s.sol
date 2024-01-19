// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
// import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract HelperConfig is Script {
  NetworkConfig public activeNetworkConfig;

  struct NetworkConfig {
      address ghoToken;
  }

  event HelperConfig__CreatedMockGhoToken(address ghoToken);

  constructor() {
      if (block.chainid == 11155111) {
          activeNetworkConfig = getSepoliaEthConfig();
      } else {
        //   activeNetworkConfig = getOrCreateAnvilEthConfig();
      }
  }

  function getSepoliaEthConfig() public pure returns (NetworkConfig memory sepoliaNetworkConfig) {
      sepoliaNetworkConfig = NetworkConfig({
          ghoToken: 0xc4bF5CbDaBE595361438F8c6a187bDc330539c60 // ETH / USD
      });
  }

//   function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory anvilNetworkConfig) {
//       // Check to see if we set an active network config
//       if (activeNetworkConfig.ghoToken != address(0)) {
//           return activeNetworkConfig;
//       }
//       vm.startBroadcast();
//       IERC20 mockGhoToken = new IERC20();
//       vm.stopBroadcast();
//       emit HelperConfig__CreatedMockGhoToken(address(mockGhoToken));

//       anvilNetworkConfig = NetworkConfig({ghoToken: address(mockGhoToken)});
//   }
}