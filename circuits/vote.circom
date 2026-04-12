pragma circom 2.1.5;

// Import hàm băm Poseidon từ thư viện circomlib
include "../node_modules/circomlib/circuits/poseidon.circom";

template Vote() {
    // 1. Dữ liệu công khai (Public Inputs - Gửi lên Smart Contract)
    signal input nullifierHash; // Mã băm đại diện cho lá phiếu (chống bầu 2 lần)
    signal input candidateId;   // ID của ứng viên được chọn

    // 2. Dữ liệu bí mật (Private Inputs - Chỉ nằm trên máy cử tri)
    signal input secretKey;     // Khóa bí mật của cử tri

    // 3. Logic Ràng buộc (Constraints)
    component poseidon = Poseidon(1);
    poseidon.inputs[0] <== secretKey;

    // RÀNG BUỘC CỐT LÕI: Hash tạo ra từ Secret Key phải TRÙNG KHỚP với nullifierHash gửi lên
    poseidon.out === nullifierHash;
    
    // Lưu ý cho GVHD: Trong tương lai sẽ tích hợp thêm MerkleTree Inclusions ở đây.
}

// Khai báo Component chính, chỉ định nullifierHash và candidateId là public
component main {public [nullifierHash, candidateId]} = Vote();