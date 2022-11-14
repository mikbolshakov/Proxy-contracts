import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers, upgrades } from "hardhat";

describe("Lock", function () {
  async function deployMyCont() {
    const [ deployer] = await ethers.getSigners();

    const StorageFactory = await ethers.getContractFactory("Storage");
    const storage = await upgrades.deployProxy(StorageFactory, [100], {
      initializer: "initialize"
    });
    await storage.deployed();

    return { storage, deployer }
  }

  describe("Deployment", function () {
    it("works", async function() {
      const { storage } = await loadFixture(deployMyCont);

      const initialVal = await storage.val();
      expect(initialVal).to.eq(100);

      const StorageFactoryV2 = await ethers.getContractFactory("StorageV2");
      const storage2 = await upgrades.upgradeProxy(storage.address, StorageFactoryV2);
      console.log(storage2);

      const tx = await storage2.inc();
      await tx.wait();

      const newVal = await storage2.val();
      expect(newVal).to.eq(101);
    });
  });
})
