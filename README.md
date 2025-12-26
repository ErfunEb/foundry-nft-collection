# Foundry NFT Collection

A **Foundry-based NFT project** containing two ERC-721 contracts:

- **BasicNft** – a simple NFT with externally supplied token URIs
- **MoodNft** – an on-chain SVG NFT whose metadata and image change based on mood

The project includes a Makefile-driven workflow for deploying and interacting with the contracts on **Anvil (local)** and **Sepolia**.

---

## 🧱 Tech Stack

- **Solidity 0.8.30**
- **Foundry** (forge, cast)
- **OpenZeppelin Contracts**
- **Makefile** for automation

---

## 📂 Contracts Overview

### 🐶 BasicNft

- ERC721 name: `Dogie`
- Symbol: `DOG`
- Each token stores a custom `tokenURI`
- Anyone can mint

```solidity
function mintNft(string memory tokenUri) public;
```

---

### 😄 MoodNft

- ERC721 name: `Mood NFT`
- Symbol: `MN`
- Fully on-chain metadata (Base64 JSON)
- SVG image switches between **HAPPY** and **SAD**
- Only owner or approved address can flip mood

```solidity
function mintNft() public;
function flipMood(uint256 tokenId) public;
```

---

## ⚙️ Environment Setup

### 1️⃣ Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

---

### 2️⃣ Create `.env` file

Copy the example:

```bash
cp .env.example .env
```

Fill in:

```env
SEPOLIA_RPC_URL=
ANVIL_KEY_NAME=
SEPOLIA_KEY_NAME=
```

> Keys must already exist in Foundry:
```bash
cast wallet list
```

---

## 🛠 Makefile Commands

### 🔹 Deploy Basic NFT (Local / Anvil)

```bash
make deploy-basic-nft
```

### 🔹 Deploy Basic NFT (Sepolia)

```bash
make deploy-basic-nft SEPOLIA=true
```

---

### 🔹 Mint Basic NFT

```bash
make mint-basic-nft
```

---

### 🔹 Deploy Mood NFT

```bash
make deploy-mood-nft
```

Supports both **local** and **Sepolia** via `SEPOLIA=true`.

---

## 📦 Deployment Artifacts

After deployment, the latest broadcast file is copied to:

```text
script/deployments/basicNft.json
```

This file contains:
- Deployed contract address
- Transaction hash
- Chain ID

---

## 🧪 Testing

### Run all tests
```bash
forge test
```

### Run tests with verbosity
```bash
forge test -vvv
```

### Run a specific test file
```bash
forge test --match-path test/BasicNft.t.sol
```

### Run a specific test function
```bash
forge test --match-test testMintNft
```

---

## 🧰 Useful Foundry Commands

```bash
forge build      # Compile contracts
forge clean      # Clear cache
forge fmt        # Format Solidity code
forge snapshot   # Gas snapshots
```

---

## 🔐 Security Notes

- Uses OpenZeppelin ERC721
- `MoodNft` enforces ownership & approvals
- No upgradeability
- Intended for learning & experimentation

---

## 📜 License

MIT
