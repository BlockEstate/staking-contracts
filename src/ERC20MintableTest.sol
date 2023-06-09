// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "openzeppelin/token/ERC20/ERC20.sol";

/**
 * Mintable ERC20 + list the minters, used for testing.
 */
contract ERC20MintableTest is ERC20 {
    address[] minters;

    constructor() ERC20("Staking test token", "STKt") {}

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    function mint(uint256 amount) external {
        _mint(msg.sender, amount);

        _addToMinterList(msg.sender);
    }

    function nbMinters() external view returns (uint256) {
        return minters.length;
    }

    function minterAddress(uint256 i) external view returns (address) {
        require(i < minters.length, "minter index overflow");

        return minters[i];
    }

    function _addToMinterList(address addr) private {
        bool found;

        for (uint256 i; i < minters.length; i++) {
            if (minters[i] == addr) found = true;
        }

        if (!found) minters.push(addr);
    }
}
