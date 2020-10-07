var Message = artifacts.require("MessageOfTheMoment");

module.exports = function(deployer) {
  deployer.deploy(Message);
};