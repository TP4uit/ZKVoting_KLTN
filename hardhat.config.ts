import { HardhatUserConfig } from "hardhat/config";
import HardhatIgnitionEthersPlugin from "@nomicfoundation/hardhat-ignition-ethers";

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  plugins: [HardhatIgnitionEthersPlugin], // <-- Đây chính là "công tắc" kích hoạt lệnh ignition
};

export default config;