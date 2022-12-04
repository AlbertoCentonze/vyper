// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.8.13;

import {Test} from "forge-std/Test.sol";
import {VyperDeployer} from "./VyperDeployer.sol";

contract VyperTest is Test {
	VyperDeployer vyperDeployer;

	function initDeployer() public {
		vyperDeployer = new VyperDeployer(vm);
	}
}
