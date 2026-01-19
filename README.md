# VaultDAO

<div align="center">
  <img src="https://img.shields.io/badge/Stellar-Soroban-purple" alt="Stellar Soroban" />
  <img src="https://img.shields.io/badge/Security-Rust-orange" alt="Rust" />
  <img src="https://img.shields.io/badge/Status-Testnet-green" alt="Status" />
</div>

**VaultDAO** is a Soroban-native treasury management dApp for high-value Stellar organizations. It brings the robust security of multi-signature wallets to the speed and efficiency of the Soroban smart contract platform.

Think of it as the **"Gnosis Safe of Stellar"** — built for DAOs, Enterprise Treasuries, and Investment Clubs.

---

## 🛡️ Features

| Feature | Description |
|---|---|
| **Multi-Signature** | **M-of-N** signing logic enforced on-chain. Requires cryptographic proof from multiple treasurers. |
| **RBAC** | Granular **Role-Based Access Control** (Admin, Treasurer, Member) defining exact permissions. |
| **Timelocks** | Large transfers (> threshold) are **locked for 24 hours** before execution, allowing emergency cancellation. |
| **Spending Limits** | Enforced **Daily** and **Weekly** allowances to prevent budget overruns or drainage. |
| **Recurring Payments** | Automate payroll and subscriptions with rigorous interval checks. |

## 🔒 Security Architecture

VaultDAO handles treasury funds, so security is paramount. The contract leverages **Rust** for memory safety and **Soroban's** simplified host environment to minimize attack vectors.

### Storage Strategy
To optimize for ledger rent and data capabilities, we use a hybrid storage model:

- **Instance Storage**: Used for `Config` (Global Settings) and `Roles`. This data is "hot" and always available to every contract invocation.
- **Persistent Storage**: Used for `Proposals` and `RecurringPayments`. These records must persist until explicitly removed or expired.
    - *TTL*: Automatically extended on access.
- **Temporary Storage**: Used for **Daily/Weekly Spending Limits**.
    - *Why?* These records are ephemeral. Once the time period (day/week) passes, the data can be safely evicted by the network, saving rent costs.

### Testing
- **100% Logic Coverage**: The multi-signature voting engine, timelock delays, and limit trackers are fully covered by unit tests in `src/test.rs`.
- **RBAC Verification**: Every sensitive function invokes `require_auth()` and checks the caller's role against the stored registry.

---

## 🛠️ Tech Stack

### Smart Contract (Rust)
- **SDK**: `soroban-sdk` v22.0.8
- **Language**: Rust (wasm32-unknown-unknown)
- **Tooling**: `soroban-cli`, `cargo`

### Frontend (React)
- **Framework**: Vite + React + TypeScript
- **Styling**: Tailwind CSS + Lucide Icons
- **Wallet**: `@stellar/freighter-api` (Browser Extension)
- **Integration**: `stellar-sdk` (Simulations & XDR)

---

## 🚀 Development Setup

### 1. Smart Contract
Ensure you have Rust and the wasm32 target installed.

```bash
# Clone the repository
git clone https://github.com/otwizzy/vaultdao.git
cd vaultdao

# Build the contract
cargo build --target wasm32-unknown-unknown --release

# Run Tests
cargo test
```

### 2. Frontend
Navigate to the frontend directory.

```bash
cd frontend

# Install dependencies
npm install

# Start the dev server
npm run dev
```

Open `http://localhost:5173` to view the dashboard.

---

## 🌊 Developer Roadmap & Contributor Guide

We are actively participating in the **Stellar Community Drips Wave**. We welcome frontend developers to help us accept mass adoption!

### Wave Contributor Path
If you are a frontend developer looking to contribute:
1.  **UI Polish**: Improve the `Proposals.tsx` component to list actual on-chain proposals using the `useVaultContract` hook.
2.  **RPC Integration**: Help building a robust "Event Listener" to update the dashboard in real-time when a proposal is approved.
3.  **Mobile Support**: Optimize the sidebar and dashboard layout for mobile wallets.

