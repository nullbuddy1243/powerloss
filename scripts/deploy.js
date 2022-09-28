// scripts/deploy.js
async function main () {
  // We get the contract to deploy
  const ChubaPowerLoss = await ethers.getContractFactory('ChubaPowerLoss');
  console.log('Deploying ChubaPowerLoss...');
  const name = 'ChubaPowerLoss';
  const uri = 'https://powerapi.up.railway.app/';
  const ticker = 'CHBPWRL'
  const chubaPowerLoss = await ChubaPowerLoss.deploy(name, uri, ticker);
  await chubaPowerLoss.deployed();
  console.log('ChubaPowerLoss deployed to:', chubaPowerLoss.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });