// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPriceOfEthInUsd() internal view returns (uint256) {
        // 0x694AA1769357215DE4FAC081bf1f309aDC325306 //Sepolia USDtoETH
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (
            ,
            /* uint80 roundID */
            int256 priceOfEthInUsd,
            ,
            ,
        ) = priceFeed /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/ .latestRoundData();
        return uint256(priceOfEthInUsd) * 1e10;
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPriceOfEthInUsd();
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        return ethAmountInUsd;
    }
}
