import '@nomiclabs/hardhat-ethers'
import '@nomiclabs/hardhat-etherscan'
import '@nomiclabs/hardhat-waffle'
import 'hardhat-typechain'
import 'hardhat-watcher'
import 'hardhat-warp'

const WARP_COMPILER_SETTINGS = {
  version: '0.8.14',
  settings: {
    optimizer: {
      enabled: true,
      runs: 800,
    },
    metadata: {
      bytecodeHash: 'none',
    },
  },
}

const port = (Math.floor(Math.random() * 1000) + 5000).toString()

export default {
  networks: {
    integratedDevnet: {
      url: `http://127.0.0.1:${port}`,

      venv: 'active', // <- for the active virtual environment with installed starknet-devnet
      // venv: "path/to/venv" <- for env with installed starknet-devnet (created with e.g. `python -m venv path/to/venv`)
      // venv: "../../starknet-devnet/.env",

      // optional devnet CLI arguments
      args: ['--seed', '0', '--timeout', '10000'],

      // stdout: "logs/stdout.log" <- dumps stdout to the file
      stdout: `.${port}.log`, // <- logs stdout to the terminal
      // stderr: "logs/stderr.log" <- dumps stderr to the file
      stderr: 'STDERR', // <- logs stderr to the terminal
    },

    hardhat: {
      allowUnlimitedContractSize: false,
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    ropsten: {
      url: `https://ropsten.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    goerli: {
      url: `https://goerli.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    kovan: {
      url: `https://kovan.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    arbitrumRinkeby: {
      url: `https://arbitrum-rinkeby.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    arbitrum: {
      url: `https://arbitrum-mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    optimismKovan: {
      url: `https://optimism-kovan.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
    optimism: {
      url: `https://optimism-mainnet.infura.io/v3/${process.env.INFURA_API_KEY}`,
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  solidity: WARP_COMPILER_SETTINGS,
  watcher: {
    test: {
      tasks: [{ command: 'test', params: { testFiles: ['{path}'] } }],
      files: ['./test/**/*'],
      verbose: true,
    },
  },
}
