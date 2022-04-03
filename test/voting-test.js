const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Voting", function () {
    // it("User should only vote once", async function () {
    //     const Voting = await ethers.getContractFactory("Voting");
    //     const voting = await Voting.deploy();
    //     await voting.deployed();
    //     voting.register("Trump");
    //     voting.vote(1);
    //     voting.vote(1);
    // });

    it("Registration period should not be exceeded", async function () {
        const Voting = await ethers.getContractFactory("Voting");
        const voting = await Voting.deploy();
        await voting.deployed();
        await voting.register("Trump");
        setTimeout(() => {console.log("this is the second message")}, 10000);
        await voting.register("Biden");
    });

    // it("Voting period should not be exceeded", async function () {
    //     const Voting = await ethers.getContractFactory("Voting");
    //     const voting = await Voting.deploy();
    //     await voting.deployed();
    //     await voting.register("Trump");
    //     await voting.vote(1);
    //     await voting.vote(1);
    // });
});
