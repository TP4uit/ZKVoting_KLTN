// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Election {
    address public admin;
    
    // Mapping lưu trữ các Nullifier đã sử dụng (true = đã bầu)
    mapping(uint256 => bool) public usedNullifiers;
    
    // Mapping đếm số phiếu cho từng ứng viên (candidateId => vote count)
    mapping(uint256 => uint256) public voteCounts;

    // Sự kiện được phát ra khi có người bầu cử thành công
    event VoteCast(uint256 indexed candidateId, uint256 nullifierHash);

    constructor() {
        admin = msg.sender;
    }

    // Hàm nhận phiếu bầu từ cử tri
    function castVote(
        uint256 candidateId,
        uint256 nullifierHash
        // Lưu ý: Các tham số ZK Proof (a, b, c) tạm ẩn để test luồng cơ bản đêm nay
    ) public {
        // 1. Kiểm tra chống bầu 2 lần (Double Voting Prevention)
        require(!usedNullifiers[nullifierHash], "Loi: Cu tri nay da bo phieu!");
        
        // 2. Logic gọi Verifier.sol để kiểm chứng ZKP sẽ nằm ở đây
        // require(verifier.verifyProof(a, b, c, [nullifierHash, candidateId]), "Loi: ZK Proof khong hop le");

        // 3. Ghi nhận phiếu bầu vào Blockchain
        usedNullifiers[nullifierHash] = true;
        voteCounts[candidateId] += 1;

        emit VoteCast(candidateId, nullifierHash);
    }

    // Hàm xem kết quả bầu cử
    function getVotes(uint256 candidateId) public view returns (uint256) {
        return voteCounts[candidateId];
    }
}