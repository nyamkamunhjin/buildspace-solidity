/* eslint-disable no-process-exit */
import { ethers } from "hardhat";

const main = async () => {
  const [owner, randomPerson] = await ethers.getSigners();
  const spotifyContractFactory = await ethers.getContractFactory(
    "SpotifyPortal",
  );
  const spotifyContract = await (spotifyContractFactory as any).deploy({
    value: ethers.utils.parseEther("1201"),
  });

  await spotifyContract.deployed();

  console.log("Contract deployed to:", spotifyContract.address);
  console.log("Contract deployed by:", owner.address);

  let waveCount;
  waveCount = await spotifyContract.getTotalWaves();

  let waveTxn = await spotifyContract.wave(
    "Hello sending a message.",
    "greenBlue",
  );
  await waveTxn.wait();

  waveCount = await spotifyContract.getTotalWaves();

  waveTxn = await spotifyContract
    .connect(randomPerson)
    .wave("MESSAGE. 🚀", "greenBlue");
  await waveTxn.wait();

  waveCount = await spotifyContract.getTotalWaves();

  console.log(`wave count: ${waveCount}`);

  const waves = await spotifyContract.getAllWaves();

  console.log({ waves });
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
