//script to automaticaly test our smart contract by compiling, deploying and executing this

async function main() {
    // const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    console.log("Contract deployed to:", waveContract.address);
    // console.log("Contract deployed by:", owner.address);

    let waveCount = await waveContract.getTotalWaves();

    let waveTxn = await waveContract.wave("A message");
    await waveTxn.wait();//wait for txn to be mined

    waveTxn = await waveContract.wave("Another message");
    await waveTxn.wait();

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);

    // waveCount = await waveContract.getTotalWaves();

    // waveTxn = await waveContract.connect(randomPerson).wave();
    // await waveTxn.wait();

    // waveCount = await waveContract.getTotalWaves();

    // //to test when someone wave us for the 2nd time:
    // waveTxn = await waveContract.connect(randomPerson).wave();
    // await waveTxn.wait();

    // waveCount = await waveContract.getTotalWaves();
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });