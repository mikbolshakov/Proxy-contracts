import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers, upgrades } from "hardhat";

describe("TransparUUPSToken", function () {
  async function deployMyToken() {
    const [ deployer] = await ethers.getSigners();

    const TokenFactory = await ethers.getContractFactory("TransparUUPSToken");
    const token = await upgrades.deployProxy(TokenFactory, [], {
      initializer: "initialize",
      kind: "uups"
    }); // kind только в случае с UUPSUpgradeable
    await token.deployed();

    return { token, deployer }
  }

  it("works", async function() {
    const { token, deployer } = await loadFixture(deployMyToken);
    const mintTx = await token.mint(deployer.address, 1000);
    await mintTx.wait();
    expect(await token.totalSupply()).to.eq(1000);

    const TokenFactory2 = await ethers.getContractFactory("TransparUUPSTokenV2");
    const token2 = await upgrades.upgradeProxy(token.address, TokenFactory2)
    expect(await token2.totalSupply()).to.eq(1000);

    const mintTx2 = await token2.mint(deployer.address, 1000);
    await mintTx2.wait();
    expect(await token.totalSupply()).to.eq(3000);
  });
})