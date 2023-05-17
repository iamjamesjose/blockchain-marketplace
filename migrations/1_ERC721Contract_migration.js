// Help Truffle find `ERC721Contract.sol` in the `/contracts` directory
const ERC721Contract = artifacts.require("ERC721Contract");

module.exports = function(deployer) {
  // Command Truffle to deploy the Smart Contract
  deployer.deploy(ERC721Contract);
};