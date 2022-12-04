// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

import {Vm} from "forge-std/Vm.sol";

contract VyperDeployer {
    Vm private vm;

    constructor(Vm _vm) {
        vm = _vm;
    }

    function deployContract(string memory fileName) public returns (address) {
        string[] memory cmds = new string[](2);
        cmds[0] = "vyper";
        cmds[1] = string.concat("src/", fileName, ".vy");

        bytes memory bytecode = vm.ffi(cmds);

        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        require(
            deployedAddress != address(0),
            "VyperDeployer could not deploy contract"
        );

        return deployedAddress;
    }

    function deployContract(string memory fileName, bytes calldata args)
        public
        returns (address)
    {
        string[] memory cmds = new string[](2);
        cmds[0] = "vyper";
        cmds[1] = string.concat("src/", fileName, ".vy");

        bytes memory _bytecode = vm.ffi(cmds);

        bytes memory bytecode = abi.encodePacked(_bytecode, args);

        address deployedAddress;
        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        require(
            deployedAddress != address(0),
            "VyperDeployer could not deploy contract"
        );

        return deployedAddress;
    }
}
