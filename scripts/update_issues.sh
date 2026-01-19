#!/bin/bash

# VaultDAO "Meaningful Work" Issue Update
# This script upgrades trivial/housekeeping issues to high-impact feature work
# as per Drips Wave guidelines.

update_issue_safe() {
    ID="$1"
    TITLE="$2"
    BODY="$3"
    LABELS="$4"
    
    echo "Updating issue #$ID: $TITLE..."
    gh issue edit "$ID" --title "$TITLE" --body "$BODY" || echo "Warning: Failed to update content for #$ID"
}

# 1. Trivial Issue Upgrade: UI -> Data-Driven Role Indicator
update_issue_safe 1 "UI: Implement User Profile & Role Fetcher" \
"### 🟢 Difficulty: Trivial (100 Points)

We need to display the connected user's permissions within the Vault. This isn't just a static badge; it requires fetching state from the contract.

### ✅ Acceptance Criteria
- Use the \`useWallet\` hook to get the current address.
- Update \`useVaultContract.ts\` to include a \`getRole(address)\` call.
- Modify the Sidebar/Header to display \"Admin\", \"Treasurer\", or \"Member\" based on the contract response.
- Use conditional Tailwind styling for the role badge colors.

### 📚 Resources
- [VaultDAO Roles Logic](https://github.com/otwizzy/VaultDAO/blob/main/contracts/vault/src/lib.rs)
- [Stellar-React Context Pattern](https://soroban.stellar.org/docs/how-to-guides/using-soroban-react)
" "stellar-wave,trivial,frontend,soroban"

# 2. Trivial Issue Upgrade: Clipboard -> Unit Conversion Safety
update_issue_safe 2 "Logic: Robust XLM-to-Stroop Conversion Utility" \
"### 🟢 Difficulty: Trivial (100 Points)

Directly passing numbers to Soroban \`i128\` values often leads to precision errors. We need a typesafe utility to handle these conversions.

### ✅ Acceptance Criteria
- Create \`src/utils/units.ts\`.
- Implement \`toStroops(amount: string)\`: Handles decimal precision without float-rounding errors.
- Implement \`fromStroops(amount: string)\`: Formats for display.
- Add basic unit tests for this utility to ensure financial accuracy.

### 📚 Resources
- [BigInt Handling in JS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt)
- [Stellar Precision Docs](https://developers.stellar.org/docs/fundamentals/transaction-lifecycle#fees)
" "stellar-wave,trivial,logic,frontend"

# 3. Trivial Issue Upgrade: Docs -> Mobile Navigation Logic
update_issue_safe 3 "UI: Implementation of Responsive Sidebar for Mobile" \
"### 🟢 Difficulty: Trivial (100 Points)

The current dashboard is optimized for desktop. We need to implement the mobile 'Hamburger' menu and overlay logic.

### ✅ Acceptance Criteria
- Modify \`DashboardLayout.tsx\` to support a toggleable mobile drawer.
- Use React State to handle the open/close transitions.
- Ensure the sidebar is hidden/collapsed on small screens while maintaining full accessibility (aria-hidden).
- Implementation must use Tailwind's \`md:\` breakpoints.

### 📚 Resources
- [Tailwind Responsive Design](https://tailwindcss.com/docs/responsive-design)
" "stellar-wave,trivial,ui,frontend"

# 4. Medium (Kept): approveProposal
update_issue_safe 4 "Frontend: Implement approveProposal transaction hook" \
"### 🟡 Difficulty: Medium (150 Points)

Extend the \`useVaultContract\` hook to allow treasurers to sign and submit approvals.

### ✅ Acceptance Criteria
- Update \`frontend/src/hooks/useVaultContract.ts\`.
- Implement \`approveProposal(proposalId: number)\`.
- Handle the Soroban XDR construction and Freighter signing flow.

### 📚 Resources
- [Stellar SDK - Invoking Contracts](https://stellar.github.io/js-stellar-sdk/SorobanRpc.html)
" "stellar-wave,medium,frontend,soroban"

# 5. Medium (Kept): Live Vault Balance
update_issue_safe 5 "Frontend: Fetch and display live Vault Balance" \
"### 🟡 Difficulty: Medium (150 Points)

The dashboard currently shows a static balance. We need to fetch the real-time XLM/SAC balance of the Vault account from the network.

### ✅ Acceptance Criteria
- Connect \`Overview.tsx\` to the Soroban RPC.
- Call the Native Token contract to get the balance.
- Format the balance correctly using our unit utility.

### 📚 Resources
- [Soroban Token Interface](https://soroban.stellar.org/docs/reference/interfaces/token-interface)
" "stellar-wave,medium,frontend,soroban"

# 6. Medium (Kept): New Proposal Modal
update_issue_safe 6 "Frontend: Create interactive NewProposalModal form" \
"### 🟡 Difficulty: Medium (150 Points)

Create the UI for treasurers to initiate new transfers.

### ✅ Acceptance Criteria
- Build \`NewProposalModal.tsx\`.
- Fields: \`Target Address\`, \`Amount\`, \`Token\`, and \`Memo\`.
- Implement real-time validation for Stellar Public Keys.

### 📚 Resources
- [Stellar StrKey Validation](https://stellar.github.io/js-stellar-sdk/StrKey.html)
" "stellar-wave,medium,frontend,ui"

# 7. High (Kept): Submit Proposal Flow
update_issue_safe 7 "Integration: Connect UI to Propose Transfer hook" \
"### 🔴 Difficulty: High (200 Points)

Wire the \`NewProposalModal\` to the actual blockchain submission logic.

### ✅ Acceptance Criteria
- Integrate \`proposeTransfer\` from our hook into the modal's submit handler.
- Show a clear \"Signing in Freighter...\" state.
- Handle success and failure toast notifications.

### 📚 Resources
- [useVaultContract hook](https://github.com/otwizzy/VaultDAO/blob/main/frontend/src/hooks/useVaultContract.ts)
" "stellar-wave,high,frontend,soroban"

# 8. High (Upgrade): Render Proposal List via Events
update_issue_safe 8 "Frontend: Implement Live Proposal History via Event Fetching" \
"### 🔴 Difficulty: High (200 Points)

Instead of just iterating IDs, use the Soroban Event RPC to build a dynamic list of active and recent proposals.

### ✅ Acceptance Criteria
- Use \`getEvents\` to find \`proposal_created\` events.
- Parse the XDR data from events to populate the UI.
- Implement basic filtering (Pending vs. Executed).

### 📚 Resources
- [Soroban RPC - getEvents](https://soroban.stellar.org/api/methods/getEvents)
" "stellar-wave,high,frontend,soroban"

# 9. High (Kept): executeProposal
update_issue_safe 9 "Feature: Implement execution logic for approved proposals" \
"### 🔴 Difficulty: High (200 Points)

Once a proposal is Approved and Timelock passed, it must be Executed.

### ✅ Acceptance Criteria
- Add \`executeProposal(proposalId: number)\` to \`useVaultContract.ts\`.
- Add \"Execute\" button to the Proposal Card which only appears if \`Status === Approved\`.
- Handle \`TimelockNotExpired\` errors clearly.

### 📚 Resources
- [VaultDAO src/lib.rs](https://github.com/otwizzy/VaultDAO/blob/main/contracts/vault/src/lib.rs)
" "stellar-wave,high,frontend,soroban"

# 10. High (Kept): SDK Bindings
update_issue_safe 10 "SDK: Generate type-safe official TypeScript Bindings" \
"### 🔴 Difficulty: High (200 Points)

Initialize the official SDK package for developers to build on top of VaultDAO.

### ✅ Acceptance Criteria
- Initialize \`sdk/package.json\` and \`tsconfig.json\`.
- Use \`stellar-cli\` to generate bindings from the WASM.
- Document how to import and use these bindings in a 3rd party project.

### 📚 Resources
- [Stellar TypeSript Bindings](https://soroban.stellar.org/docs/how-to-guides/invoke-contract/typescript-bindings)
" "stellar-wave,high,sdk,rust"

echo \"All issues refined for Meaningful Work standards!\"
