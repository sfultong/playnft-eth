const Site = artifacts.require("Site");

module.exports = function (deployer) {
	deployer.deploy(Site);
}
