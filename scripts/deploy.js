async function main() {
    // const [deployer] = await ethers.getSigners();

    // console.log("Deploying contracts with the account:", deployer.address);

    // console.log("Account balance:", (await deployer.getBalance()).toString());

    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({ value: ethers.utils.parseEther("0.1") });
    await waveContract.deployed();//to know when the contract is deployed
    // const token = await Token.deploy();

    console.log("WavePortal address:", waveContract.address);
}


main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });