
const main =  async() =>{

    const [owner,randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
        value:hre.ethers.utils.parseEther("0.05")
    });
    await waveContract.deployed();

    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log("contract balance",hre.ethers.utils.formatEther(contractBalance));

    let waveCount;
    waveCount = await waveContract.getMyWaves();

    let waveFunc;
    waveFunc = await waveContract.waveAtMe("Hello This is me");
    await waveFunc.wait();

    const waveFun2 = await waveContract.waveAtMe("This is second me");
    await waveFun2.wait();


    contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log("contract balance after making a transaction",hre.ethers.utils.formatEther(contractBalance));

    // waveCount = await waveContract.getMyWaves();

    // waveFunc = await waveContract.connect(randomPerson).waveAtMe("This is the second user messageing you");
    // await waveFunc.wait();

    waveCount = await waveContract.getMyWaves();

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
    
}

const runMain = async() =>{
    try{
        await main();
        process.exit(0);
    }
    catch(err){
        console.log(err);
        process.exit(1);
    }
}

runMain();