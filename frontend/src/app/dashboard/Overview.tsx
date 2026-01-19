import React from 'react';

const Overview: React.FC = () => {
    return (
        <div className="space-y-6">
            <h2 className="text-3xl font-bold">Treasury Overview</h2>

            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                {/* Balance Card */}
                <div className="bg-gray-800 p-6 rounded-xl border border-gray-700 shadow-lg">
                    <h3 className="text-gray-400 text-sm font-medium uppercase">Total Balance</h3>
                    <p className="text-4xl font-bold mt-2">$0.00</p>
                    <div className="mt-4 flex items-center text-sm text-green-400">
                        <span>+0.0% from last week</span>
                    </div>
                </div>

                {/* Active Proposals */}
                <div className="bg-gray-800 p-6 rounded-xl border border-gray-700 shadow-lg">
                    <h3 className="text-gray-400 text-sm font-medium uppercase">Active Proposals</h3>
                    <p className="text-4xl font-bold mt-2">0</p>
                    <div className="mt-4 text-sm text-gray-400">
                        <span>0 needing your approval</span>
                    </div>
                </div>

                {/* Signers */}
                <div className="bg-gray-800 p-6 rounded-xl border border-gray-700 shadow-lg">
                    <h3 className="text-gray-400 text-sm font-medium uppercase">Active Signers</h3>
                    <p className="text-4xl font-bold mt-2">0</p>
                    <div className="mt-4 text-sm text-gray-400">
                        <span>Threshold: 0/0</span>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Overview;
