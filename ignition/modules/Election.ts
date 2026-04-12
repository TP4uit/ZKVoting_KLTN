// @ts-nocheck
import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("ElectionModule", (m) => {
  const election = m.contract("Election");
  
  return { election };
});