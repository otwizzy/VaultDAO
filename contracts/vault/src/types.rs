//! VaultDAO - Type Definitions
//!
//! Core data structures for the multisig treasury contract.

use soroban_sdk::{contracttype, Address, Symbol, Vec};

/// Vault configuration
#[contracttype]
#[derive(Clone, Debug)]
pub struct Config {
    /// List of authorized signers
    pub signers: Vec<Address>,
    /// Required number of approvals (M in M-of-N)
    pub threshold: u32,
    /// Maximum amount per proposal (in stroops)
    pub spending_limit: i128,
    /// Maximum aggregate daily spending (in stroops)
    pub daily_limit: i128,
    /// Maximum aggregate weekly spending (in stroops)
    pub weekly_limit: i128,
    /// Amount threshold above which a timelock applies
    pub timelock_threshold: i128,
    /// Delay in ledgers for timelocked proposals
    pub timelock_delay: u64,
}

/// User roles for RBAC
#[contracttype]
#[derive(Clone, Debug, PartialEq, Eq)]
#[repr(u32)]
pub enum Role {
    /// Read-only access (default)
    Member = 0,
    /// Can propose and approve transfers
    Treasurer = 1,
    /// Can modify config, add/remove signers, change roles
    Admin = 2,
}

/// Proposal status lifecycle
#[contracttype]
#[derive(Clone, Debug, PartialEq, Eq)]
#[repr(u32)]
pub enum ProposalStatus {
    /// Awaiting approvals
    Pending = 0,
    /// Threshold met, ready for execution
    Approved = 1,
    /// Successfully executed
    Executed = 2,
    /// Rejected by admin or proposer
    Rejected = 3,
    /// Past expiration ledger
    Expired = 4,
}

/// Transfer proposal
#[contracttype]
#[derive(Clone, Debug)]
pub struct Proposal {
    /// Unique proposal ID
    pub id: u64,
    /// Address that created the proposal
    pub proposer: Address,
    /// Recipient of the transfer
    pub recipient: Address,
    /// Token contract address (SAC or custom)
    pub token: Address,
    /// Amount to transfer (in token's smallest unit)
    pub amount: i128,
    /// Optional memo/description
    pub memo: Symbol,
    /// Addresses that have approved
    pub approvals: Vec<Address>,
    /// Current status
    pub status: ProposalStatus,
    /// Ledger sequence when created
    pub created_at: u64,
    /// Ledger sequence when proposal expires
    pub expires_at: u64,
    /// Earliest ledger sequence when proposal can be executed (0 if no timelock)
    pub unlock_ledger: u64,
}

/// Recurring payment schedule
#[contracttype]
#[derive(Clone, Debug)]
pub struct RecurringPayment {
    pub id: u64,
    pub proposer: Address,
    pub recipient: Address,
    pub token: Address,
    pub amount: i128,
    pub memo: Symbol,
    /// Interval in ledgers (e.g., 172800 for ~1 week)
    pub interval: u64,
    /// Next scheduled execution ledger
    pub next_payment_ledger: u64,
    /// Total payments made so far
    pub payment_count: u32,
    /// Configured status (Active/Stopped)
    pub is_active: bool,
}
