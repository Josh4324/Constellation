const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("eco", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deploy() {
    // Contracts are deployed using the first signer/account by default
    const [owner, user1, user2, user3, user4, user5] =
      await ethers.getSigners();

    const ECO = await ethers.getContractFactory("ECO4Reward");
    const LOT = await ethers.getContractFactory("ECO4RewardLotteryDaily");
    const eco = await ECO.deploy();
    const lot = await LOT.deploy(
      eco.target,
      "2",
      "0x9fe0eebf5e446e3c998ec9bb19951541aee00bb90ea201ae456421a2ded86805",
      5000,
      "0x271682deb8c4e0901d1a1550ad2e64d568e69909"
    );

    return { eco, owner, user1, user2, user3, user4, user5, lot };
  }

  describe("eco", function () {
    it("Test 1", async function () {
      const { eco, user1, user2, user3, user4, owner, lot } = await loadFixture(
        deploy
      );

      function sleep(ms) {
        return new Promise((resolve) => setTimeout(resolve, ms));
      }

      console.log("total", await ethers.provider.getBalance(owner.address));
      console.log("total", await ethers.provider.getBalance(user1.address));

      await eco.donateOrFund({ value: ethers.parseEther("1000") });

      await eco.addAdmin(user1.address);
      await eco.addAdmin(lot.target);

      await eco.connect(user2).registerAction("env", "desc", "proof");

      await eco.connect(user1).confirmAction(0, 5, true);

      await eco.connect(user3).registerWaste(100, true);

      await eco.connect(user1).confirmWaste(0, 5, true);

      await eco.registerTrees(5, "loc");

      await eco.connect(user1).confirmTress(0, 5, true);

      await sleep(10000);

      await eco.registerTrees(5, "loc");

      await eco.connect(user1).confirmTress(0, 5, true);

      await eco.getPaid(5);
      console.log("total", await ethers.provider.getBalance(owner.address));

      await eco.connect(user2).registerAction("env", "desc", "proof");

      await eco.connect(user1).confirmAction(0, 5, true);

      await eco.addPoint(10, user2.address);

      console.log(await eco.getUserData(user2.address));

      //console.log(await lot.getDailyLotteryUsers());

      //console.log(await lot.getStreakUsers());

      //console.log(await lot.getUserInfo(0));
      //console.log(await lot.getUserInfo(1));
      console.log(await eco.getUserInfo(2));

      //console.log(await eco.getActions());

      //console.log(await eco.getWasteActions());

      //console.log(await eco.getTreeActions());
      //console.log("tot", await ethers.provider.getBalance(eco.target));
    });
  });
});
