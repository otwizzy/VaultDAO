import { useState } from 'react';
import {
    rpc,
    scValToNative,
    xdr,
    Address,
    TransactionBuilder,
    SorobanRpc
} from 'stellar-sdk';
import { signTransaction } from '@stellar/freighter-api';
import { useWallet } from '../context/WalletContext';
import { parseError } from '../utils/errorParser';

// Replace with your actual Contract ID
const CONTRACT_ID = "CDXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
const NETWORK_PASSPHRASE = "Test SDF Network ; September 2015";
const RPC_URL = "https://soroban-testnet.stellar.org";

const server = new SorobanRpc.Server(RPC_URL);

export const useVaultContract = () => {
    const { address, isConnected } = useWallet();
    const [loading, setLoading] = useState(false);

    const proposeTransfer = async (
        recipient: string,
        token: string,
        amount: string, // passed as string to handle large numbers safely
        memo: string
    ) => {
        if (!isConnected || !address) {
            throw new Error("Wallet not connected");
        }

        setLoading(true);
        try {
            // 1. Get latest ledger/account data
            const account = await server.getAccount(address);

            // 2. Build Transaction
            const tx = new TransactionBuilder(account, { fee: "100" })
                .setNetworkPassphrase(NETWORK_PASSPHRASE)
                .setTimeout(30)
                .addOperation(xdr.Operation.invokeHostFunction({
                    func: xdr.HostFunction.hostFunctionTypeInvokeContract([
                        xdr.ScVal.scvAddress(Address.fromString(CONTRACT_ID).toScAddress()),
                        xdr.ScVal.scvSymbol("propose_transfer"),
                        xdr.ScVal.scvVec([
                            // Args: proposer, recipient, token, amount, memo
                            new Address(address).toScVal(),
                            new Address(recipient).toScVal(),
                            new Address(token).toScVal(),
                            xdr.ScVal.scvI128(xdr.Int128Parts.fromId(amount)), // Simplified for demo
                            xdr.ScVal.scvSymbol(memo),
                        ]),
                    ]),
                    auth: [], // Authorization handled by simulation usually
                }))
                .build();

            // 3. Simulate Transaction (Check required Auth)
            const simulation = await server.simulateTransaction(tx);
            if (SorobanRpc.Api.isSimulationError(simulation)) {
                throw new Error(`Simulation Failed: ${simulation.error}`);
            }

            // Assemble transaction with simulation data (resources/auth)
            const preparedTx = SorobanRpc.assembleTransaction(tx, simulation).build();

            // 4. Sign with Freighter
            const signedXdr = await signTransaction(preparedTx.toXDR(), {
                network: "TESTNET",
            });

            // 5. Submit Transaction
            const response = await server.sendTransaction(new TransactionBuilder.fromXDR(signedXdr, NETWORK_PASSPHRASE));

            if (response.status !== "PENDING") {
                throw new Error("Transaction submission failed");
            }

            // 6. Poll for status (Simplified)
            // Real app should loop check status
            return response.hash;

        } catch (e: any) {
            // Parse Error
            const parsed = parseError(e);
            throw parsed;
        } finally {
            setLoading(false);
        }
    };

    return {
        proposeTransfer,
        loading
    };
};
