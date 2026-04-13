// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Verifier.sol"; // Import contract xác thực của snarkjs

contract Election {
    address public admin;
    Groth16Verifier public verifier;
    
    mapping(uint256 => bool) public usedNullifiers;
    mapping(uint256 => uint256) public voteCounts;

    event VoteCast(uint256 indexed candidateId, uint256 nullifierHash);

    // Truyền địa chỉ của Verifier vào khi deploy
    constructor(address _verifierAddress) {
        admin = msg.sender;
        verifier = Groth16Verifier(_verifierAddress);
    }

    // Nhận mảng tham số a, b, c (chính là Proof) và mảng input [nullifierHash, candidateId]
    function castVote(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[2] memory input 
    ) public {
        uint256 nullifierHash = input[0];
        uint256 candidateId = input[1];

        // 1. Chống bầu 2 lần
        require(!usedNullifiers[nullifierHash], "Loi: Cu tri nay da bo phieu!");
        
        // 2. Xác minh ZK Proof ẩn danh
        require(verifier.verifyProof(a, b, c, input), "Loi: ZK Proof khong hop le");

        // 3. Ghi nhận phiếu bầu
        usedNullifiers[nullifierHash] = true;
        voteCounts[candidateId] += 1;

        emit VoteCast(candidateId, nullifierHash);
    }

    function getVotes(uint256 candidateId) public view returns (uint256) {
        return voteCounts[candidateId];
    }
}