// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 3e18;
    address[] public funders;
    mapping(address funder => uint256 amount) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    function fund() public payable {
        require(msg.value.getConversionRate() > MINIMUM_USD, "didn't send enough ETH");
        // 1e18 = 1 ETH = 1000000000000000000
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function withdraw() public ownerOnly {
        for (uint256 fi = 0; fi < funders.length; fi++) {
            address funder = funders[fi];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);

        //transfer: if exceeds gas amount, will fail and revert.
        //payable(msg.sender).transfer(address(this).balance);

        //send: if exceeds gas amount, will return boolean but revert must be done manually
        //bool isSendSuccessful = payable(msg.sender).send(address(this).balance);
        //require(isSendSuccessful, "Send failed");

        //call: can call any function on an address. Returns return data (e.g bytes) and success/fail
        (bool isCallSuccessful, /*bytes memory dataReturned*/ ) =
            payable(msg.sender).call{value: address(this).balance}("");
        require(isCallSuccessful, "Call failed");
    }

    modifier ownerOnly() {
        //_; // if modifier is attached before the code, this _ tells the codeflow to proceed with a function before modifier
        require(msg.sender == i_owner, "Sender is not an owner");
        _; // if modifier is attached after the code, this _ tells the codeflow to proceed with a function after modifier
    }
}
