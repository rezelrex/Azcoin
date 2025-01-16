

// SPDX-License-Identifier: GPL-3.0
// Azcoins ICO


// Version of Compiler
pragma solidity ^0.8.26;

contract azcoin_ico {
    //intoducing max_num of azcoins available for sale
    uint public max_azcoins = 1000000;

    //Introducing USD to Azcoins conversion rate
    uint public usd_to_azcoins = 1000;

    //Introducing total number of azcoins bought by investors
    uint public total_azcoins_bought = 0;

    //Mapping from investor address to its equity in Azcoins and USD
    mapping(address => uint) equity_azcoins;
    mapping(address => uint) equity_usd;

    //Checking if an investor can buy Azcoins
    modifier can_buy_azcoins(uint usd_invested) {
        require (usd_invested * usd_to_azcoins + total_azcoins_bought <= max_azcoins);
        _;
    }

    //Getting the equity in Azcoins of an investor
    function equity_in_azcoins(address investor) external view returns (uint) {
        return equity_azcoins[investor];
    }

    //Getting the equity in USD of an investor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    //Buying Azcoins
    function buy_azcoins(address investor, uint usd_invested) external 
    can_buy_azcoins(usd_invested) {
        uint azcoins_bought = usd_invested * usd_to_azcoins;
        equity_azcoins[investor] += azcoins_bought;
        equity_usd[investor] = equity_azcoins[investor] / usd_to_azcoins;
        total_azcoins_bought += azcoins_bought;
    }
    

    

    //Selling Azcoins
    function sell_azcoins(address investor, uint azcoins_sold) external {
        equity_azcoins[investor] -= azcoins_sold;
        equity_usd[investor] = equity_azcoins[investor] / 1000;
        total_azcoins_bought -= azcoins_sold;
    }
}