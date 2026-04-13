// @ts-nocheck
import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("ElectionModule", (m) => {
  // 1. Deploy Verifier trước
  const verifier = m.contract("Groth16Verifier");
  
  // 2. Deploy Election và truyền địa chỉ Verifier vào constructor
  const election = m.contract("Election", [verifier]);
  
  return { verifier, election };
});