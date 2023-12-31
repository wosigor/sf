//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.0;

import "@requestnetwork/smart-contracts/contracts/payment/ERC20TransferableReceivable";

// This is the main building block for smart contracts.
contract Marketplace {
    // A mapping is a key/value map. Here we store each stream
    mapping(address => address) streams;

    // The Transfer event helps off-chain applications understand
    // what happens within your contract.
    event Lend(address indexed _from, address indexed _to, uint256 _value);

    /**
     * Contract initialization.
     */
    constructor() {}

    /**
     * A function to transfer tokens.
     *
     * The `external` modifier makes a function *only* callable from *outside*
     * the contract.
     */
    function lend(
        address borrower,
        uint256 amount,
        bytes calldata paymentReference,
        address erc20Addr
    ) external {
        receivable = ERC20TransferableReceivable(
            "Request Network Transferable Receivable",
            "tREC",
            msg.sender
        );
        receivable.mint(to, paymentReference, amount, erc20Addr);
        receivable.payOwner(
            receivable._receivableTokenId,
            amount,
            paymentReference,
            1,
            this.address
        );
        // transfer stream to the lender

        emit Lend(borrower, msg.sender, amount);
    }
}
