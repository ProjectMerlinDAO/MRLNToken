# MRLN Token - ERC20 Vesting Contract for Project Merlin

**MRLN Token** is an ERC20-based vesting project designed to manage the release of tokens according to the tokenomics structure. This repository includes smart contracts that handle Token Generation Events (TGE), cliff periods, vesting schedules, and token sales.

## Overview

The MRLN Token ecosystem includes the following smart contracts:

1. **MRLNVesting**: Manages the vested release of MRLN tokens to specified addresses. These addresses, belonging to project owners, are assigned tokens based on different vesting schedules.
2. **MRLNPrivateSwap**: Handles private token sales, where users can purchase MRLN tokens at a fixed rate. Tokens are locked until the cliff period ends and then gradually released.
3. **MRLNStrategicSale**: Oversees strategic token sales conducted via private legal agreements. The project owner adds the buyer's address and token amount as a beneficiary to the contract.

Visit our platform: [https://projectmerlin.io](https://projectmerlin.io)

## Smart Contracts

### 🔒 MRLNVesting Contract
Ensures tokens are vested according to the defined schedule. After the cliff period ends, tokens are released incrementally to the beneficiaries' addresses.

### 💸 MRLNPrivateSwap Contract
Users can buy vested tokens at a fixed rate during the private sale. After the cliff ends, tokens are released in accordance with the vesting schedule.

### 🤝 MRLNStrategicSale Contract
Manages strategic sales via legal agreements. Project owners add the buyer's address and purchased amount as a beneficiary to ensure smooth token release.

## Tokenomics

The MRLN Token operates under a detailed tokenomics structure:

| Category      | % of Supply | Number of Tokens | Initial Unlock % | Monthly Unlock % | Cliff (Months) | Vesting (Months) | Total Release (Months) |
|---------------|-------------|------------------|------------------|------------------|----------------|-------------------|------------------------|
| Seed          | 2.50%       | 20,000,000       | 2.0%             | 0.05%            | 4              | 10                | 14                     |
| Private       | 2.50%       | 20,000,000       | 2.0%             | 0.05%            | 3              | 10                | 13                     |
| Strategic     | 2.00%       | 16,000,000       | 2.5%             | 0.05%            | 2              | 8                 | 10                     |
| Public        | 5.00%       | 40,000,000       | 10.0%            | 0.50%            | 0              | 16                | 16                     |
| Airdrop       | 2.00%       | 16,000,000       | 0.0%             | 0.00%            | 6              | 25                | 31                     |
| Operations    | 9.00%       | 72,000,000       | 0.0%             | 0.00%            | 1              | 40                | 41                     |
| Marketing     | 6.00%       | 48,000,000       | 0.0%             | 0.00%            | 1              | 30                | 31                     |
| Grants        | 15.00%      | 120,000,000      | 0.0%             | 0.00%            | 12             | 30                | 42                     |
| Dev Team      | 12.00%      | 96,000,000       | 0.0%             | 0.00%            | 5              | 50                | 55                     |
| Treasury      | 30.00%      | 240,000,000      | 0.0%             | 0.00%            | 18             | 40                | 58                     |
| Liquidity     | 13.00%      | 104,000,000      | 20.0%            | 2.60%            | 3              | 16                | 19                     |
| Advisors      | 1.00%       | 8,000,000        | 0.0%             | 0.00%            | 4              | 10                | 14                     |
| **Total**     | **100.00%** | **800,000,000**  | **36.50%**       | **3.25%**        |                |                   |                         |

## Getting Started

### Prerequisites

Ensure that you have the following installed:
- [Node.js](https://nodejs.org/)
- [Hardhat](https://hardhat.org/) for Ethereum development and testing

### Development Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/ProjectMerlinDAO/MRLNToken.git
    ```

2. Navigate to the project directory:

    ```bash
    cd MRLNToken
    ```

3. Install dependencies:

    ```bash
    npm install
    ```

4. Compile the smart contracts:

    ```bash
    npx hardhat compile
    ```

5. Run tests:

    ```bash
    npx hardhat test
    ```

### Deployment

To deploy the contracts, run the following command:

```bash
npx hardhat run scripts/deploy.js --network <network_name>

## Contract Interaction

Once the contracts are deployed, you can interact with them using the Hardhat console or scripts located in the `scripts/` directory. Example script usage:

```bash
npx hardhat run scripts/interact.js --network <network_name>

## Learn More

For additional resources on how to use these contracts and their functionality, check out:

- [ERC20 Token Standard](https://eips.ethereum.org/EIPS/eip-20)
- [Vesting in Tokenomics](https://medium.com/vesting-guide)
- [Hardhat Documentation](https://hardhat.org/docs/)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/ProjectMerlinDAO/MRLNToken/blob/main/LICENSE) file for details.
