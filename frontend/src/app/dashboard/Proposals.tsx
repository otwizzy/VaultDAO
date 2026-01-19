import React from 'react';

const Proposals: React.FC = () => {
    return (
        <div className="space-y-6">
            <div className="flex justify-between items-center">
                <h2 className="text-3xl font-bold">Proposals</h2>
                <button className="bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-medium">
                    New Proposal
                </button>
            </div>

            <div className="bg-gray-800 rounded-xl border border-gray-700 overflow-hidden">
                <div className="p-8 text-center text-gray-400">
                    <p>No proposals found.</p>
                </div>
            </div>
        </div>
    );
};

export default Proposals;
