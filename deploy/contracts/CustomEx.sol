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

   function _transactionHistory(string memory tokenName, string memory etherToken, uint256 inputValue, uint256 outputValue) internal {
      _historyIndex++;
      uint256 _historyId = _historyIndex;
      History storage history = historys[_historyId];
      
      history.historyId = _historyId;
      history.userAddress = msg.sender;
      history.tokenA = tokenName;
      history.tokenB = etherToken;
      history.inputValue = inputValue;
      history.outputValue = outputValue;
   }

   function swapEthToToken(string memory tokenName) public payable returns(uint256) {
      uint256 inputValue = msg.value; 
      uint256 outputValue = (inputValue / ethValue) * 10 ** 18; //convert to 18 decimal places

      require(tokenInstanceMap[tokenName].transfer(msg.sender, outputValue));

      string memory etherToken = "Ether";

      _transactionHistory(tokenName, etherToken, inputValue, outputValue);
      return outputValue;
   }
}