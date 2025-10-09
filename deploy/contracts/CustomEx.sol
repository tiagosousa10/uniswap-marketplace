// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import @openzeppelin/contracts/token/ERC20/ERC20.sol;

contract CustomToken is ERC20 {
   contructor(string memory name, string memory symbol) ERC20 (name, symbol) {
      _mint(msg.sender, 10000000 * 10**18);
   }
}

contract CustomDex {
   //custom tokens to be initialized
   string [] public tokens = ["Tether USD", "BNB", "USD Coin" ,"stETH", "TRON", "Matic Token", "SHIBA INU", "Uniswap"];

   // map to maintain the tokens and its instances
   mapping(string => ERC20) public tokenInstanceMap;

   uint256 public ethValue = 100000000000000;

   struct History {
      uint256 historyId;
      string tokenA;
      string tokenB;
      uint256 inputValue;
      uint256 outputValue;
      address userAddress;

   }

   uint256 public _historyIndex;
   mapping(uint256 => History) public historys;

   constructor() {
      for(uint i=0; i< tokens.length; i++) {
         CustomToken token = new CustomToken(tokens[i], tokens[i]);
         tokenInstanceMap[tokens[i]] = token;
      }

   }

   function getBalance(string memory tokenName,address _address) public view returns (uint256)  {
      return tokenInstanceMap[tokenName].balanceOf(_address);
   }

   function getTotalSupply(string memory tokenName) public view returns(uint256) {
      return tokenInstanceMap[tokenName].totalSupply();
   }

   function getName(string memory tokenName) public view returns(string memory) {
      return tokenInstanceMap[tokenName].name();
   }

   function getTokenAddress(string memory tokenName) public view returns(address) {
      return address(tokenInstanceMap[tokenName]);
   }

   function getEthBalance() public view returns(uint256) {
      return address(this).balance;
   }
}