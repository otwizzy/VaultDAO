#!/bin/bash

# VaultDAO Drips Wave Issue Tool
# This script uses the approved "Stellar-Wave" pattern

# Function to update or create issue
create_stellar_wave_issue() {
    TITLE="$1"
    BODY="$2"
    LABELS="$3"
    
    echo "Creating issue: $TITLE..."
    gh issue create --title "$TITLE" --body "$BODY" --label "$LABELS"
}

# 1. UI: StatusBadge
create_stellar_wave_issue "UI: Create reusable StatusBadge Component" \
"### 🟢 Difficulty: Trivial (100 Points)

We need a flexible Badge component to display the lifecycle states of Vault proposals (Pending, Approved, Rejected, Executed).

### ✅ Acceptance Criteria
- Create \`src/components/StatusBadge.tsx\` using React + Tailwind.
- Support variants: \`Pending\` (Yellow/Amber), \`Approved\` (Green/Emerald), \`Rejected\` (Red/Rose), \`Executed\` (Indigo/Blue), \`Expired\` (Gray).
- Ensure consistent padding (\`px-2 py-1\`) and rounded corners (\`rounded-full\`).
- Export a simple component: \`<StatusBadge status=\"Approved\" />\`.

### 📚 Resources
- [Tailwind Colors](https://tailwindcss.com/docs/customizing-colors)
- [Lucide Icons (Optional)](https://lucide.dev/icons)
" "stellar-wave,trivial,ui,frontend"

# 2. UI: Copy-to-Clipboard
create_stellar_wave_issue "UI: Add Copy-to-Clipboard for Wallet Addresses" \
"### 🟢 Difficulty: Trivial (100 Points)

Improve the UX by allowing users to copy the full Stellar address from the truncated view in the header and sidebar.

### ✅ Acceptance Criteria
- Implement \`navigator.clipboard.writeText\` for address copying.
- Add a clickable Lucide \`Copy\` icon next to the address in \`DashboardLayout.tsx\`.
- Provide visual feedback (e.g., change icon to \`Check\` for 2 seconds or show a small toast).
- Ensure accessibility (proper aria-labels).

### 📚 Resources
- [Lucide Icons](https://lucide.dev/icons/copy)
- [Web Clipboard API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard_API)
" "stellar-wave,trivial,ui,frontend"

# 3. Docs: TESTING.md
create_stellar_wave_issue "Docs: Create comprehensive TESTING.md guide" \
"### 🟢 Difficulty: Trivial (100 Points)

Help our contributors understand how to verify the VaultDAO smart contract logic.

### ✅ Acceptance Criteria
- Create \`docs/TESTING.md\`.
- Include instructions for \`cargo test\`.
- Explain how our 2-of-3 multisig tests work in \`src/test.rs\`.
- Document the role of \`mock_all_auths()\` in Soroban testing.

### 📚 Resources
- [Soroban Testing Documentation](https://soroban.stellar.org/docs/reference/rust/testutils)
- [VaultDAO src/test.rs](https://github.com/otwizzy/VaultDAO/blob/main/contracts/vault/src/test.rs)
" "stellar-wave,trivial,documentation"

# 4. Frontend: approveProposal
create_stellar_wave_issue "Frontend: Implement approveProposal transaction hook" \
"### 🟡 Difficulty: Medium (150 Points)

Extend our custom \`useVaultContract\` hook to allow treasurers to sign and submit approvals for pending proposals.

### ✅ Acceptance Criteria
- Update \`frontend/src/hooks/useVaultContract.ts\`.
- Implement \`approveProposal(proposalId: number)\`.
- Handle the Soroban XDR construction and Freighter signing flow.
- Ensure the transaction is simulated first to get gas requirements.

### 📚 Resources
- [Stellar SDK - Invoking Contracts](https://stellar.github.io/js-stellar-sdk/SorobanRpc.html)
- [VaultDAO Contract Logic (approve_proposal)](https://github.com/otwizzy/VaultDAO/blob/main/contracts/vault/src/lib.rs)
" "stellar-wave,medium,frontend,soroban"

# 5. Frontend: Live Vault Balance
create_stellar_wave_issue "Frontend: Fetch and display live Vault Balance" \
"### 🟡 Difficulty: Medium (150 Points)

The dashboard currently shows a static balance. We need to fetch the real-time XLM/SAC balance of the Vault account from the network.

### ✅ Acceptance Criteria
- Connect \`Overview.tsx\` to the Soroban RPC.
- Call the Native Token contract (or SAC) to get the balance of our Vault's Address.
- Format the balance correctly (Stroops to XLM conversions).
- Add a \"Refresh\" button or use a polling interval.

### 📚 Resources
- [Soroban Token Interface](https://soroban.stellar.org/docs/reference/interfaces/token-interface)
- [JS Stellar SDK - getAccount](https://stellar.github.io/js-stellar-sdk/Account.html)
" "stellar-wave,medium,frontend,soroban"

# 6. Frontend: New Proposal Modal
create_stellar_wave_issue "Frontend: Create interactive NewProposalModal form" \
"### 🟡 Difficulty: Medium (150 Points)

Create the UI for treasurers to initiate new transfers.

### ✅ Acceptance Criteria
- Build \`NewProposalModal.tsx\`.
- Fields: \`Target Address\`, \`Amount\`, \`Token\`, and \`Memo\`.
- Use \`stellar-sdk\` to validate that the input address is a valid Stellar Public Key (\`StrKey\`).
- Ensure the modal is responsive and high-quality (glassmorphism style).

### 📚 Resources
- [Headless UI (Optional)](https://headlessui.com/react/dialog)
- [Stellar StrKey Validation](https://stellar.github.io/js-stellar-sdk/StrKey.html)
" "stellar-wave,medium,frontend,ui"

# 7. Integration: Submit Proposal Flow
create_stellar_wave_issue "Integration: Connect UI to Propose Transfer hook" \
"### 🔴 Difficulty: High (200 Points)

Wire the \`NewProposalModal\` to the actual blockchain submission logic.

### ✅ Acceptance Criteria
- Integrate \`proposeTransfer\` from our hook into the modal's submit handler.
- Show a clear \"Signing in Freighter...\" state.
- Handle success and failure toast notifications.
- Refresh the UI state after a successful submission.

### 📚 Resources
- [useVaultContract hook](https://github.com/otwizzy/VaultDAO/blob/main/frontend/src/hooks/useVaultContract.ts)
" "stellar-wave,high,frontend,soroban"

# 8. Frontend: Display Proposals List
create_stellar_wave_issue "Frontend: Render dynamic list of Active Proposals" \
"### 🔴 Difficulty: High (200 Points)

Replace the static placeholder in \`Proposals.tsx\` with data fetched periodically from the contract.

### ✅ Acceptance Criteria
- Fetch proposal data from contract storage.
- Render a list of cards showing ID, Amount, Recipient, and Status.
- Use the \`StatusBadge\` component.
- Handle empty states gracefully.

### 📚 Resources
- [Stellar Contract Data Indexing](https://soroban.stellar.org/api/methods/getLedgerEntry)
" "stellar-wave,high,frontend,soroban"

# 9. Feature: Implement executeProposal Hook
create_stellar_wave_issue "Feature: Implement execution logic for approved proposals" \
"### 🔴 Difficulty: High (200 Points)

Proposals that meet the threshold and pass the timelock must be executed.

### ✅ Acceptance Criteria
- Implement \`executeProposal(id)\` in the SDK/Hook.
- Add an \"Execute\" action button to proposal cards that only appears when \`unlock_ledger\` is reached.
- Handle the error if a user tries to execute too early (Timelock violation).

### 📚 Resources
- [VaultDAO Timelock Logic](https://github.com/otwizzy/VaultDAO/blob/main/contracts/vault/src/lib.rs)
" "stellar-wave,high,frontend,soroban"

# 10. SDK: Official TypeScript Bindings
create_stellar_wave_issue "SDK: Generate type-safe official TypeScript Bindings" \
"### 🔴 Difficulty: High (200 Points)

Replace manual XDR construction with official, type-safe bindings generated from the Contract metadata.

### ✅ Acceptance Criteria
- Setup \`sdk/package.json\` with proper dependencies.
- Use \`stellar-cli\` to generate bindings from the WASM file.
- Export a clean interface that the frontend can consume.
- Document the generator script in the SDK README.

### 📚 Resources
- [Stellar CLI - Bindings Guide](https://soroban.stellar.org/docs/how-to-guides/invoke-contract/typescript-bindings)
" "stellar-wave,high,sdk,rust"
