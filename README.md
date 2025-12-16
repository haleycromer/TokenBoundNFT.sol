# TokenBoundNFT.sol
a next-gen ERC‑6551 Token-Bound Account (TBA) contract
# TokenBoundNFT (ERC-6551)

TokenBoundNFT is a next-generation ERC721 smart contract where each NFT acts as a **programmable on-chain wallet/account**.  
This contract implements the **ERC‑6551 Token-Bound Account** pattern, allowing NFTs to **own and manage other tokens**, making them autonomous on-chain agents.

## Features

- **NFT as Wallet/Account:** Each minted NFT can hold ERC20, ERC721, and ERC1155 tokens.  
- **Ownership Controls:** The NFT owner can send tokens from the NFT account.  
- **Multi-Token Support:** Interact with ERC20, ERC721, and ERC1155 from a single NFT account.  
- **Upgradeable Ownership:** NFT owners can transfer account control.  
- **Events & Logging:** All token transfers and account updates are emitted as events.  
- **OpenZeppelin Standards:** Inherits ERC721 and Ownable for safe and auditable logic.

## Deployment Parameters

When deploying the contract, provide:

- `name_` – Name of the NFT collection (e.g., "TokenBoundNFT")  
- `symbol_` – Symbol for the collection (e.g., "TBAC")  

## Usage

1. **Minting NFT Accounts:**  
   Owner calls `mint(to, tokenId)` to create a new NFT that also acts as a wallet.  

2. **Managing Tokens:**  
   NFT owners can call:
   - `sendERC20(tokenId, token, to, amount)`  
   - `sendERC721(tokenId, token, nftId, to)`  
   - `sendERC1155(tokenId, token, id, amount, data, to)`  

3. **Updating NFT Account Owner:**  
   NFT owner can call `updateAccountOwner(tokenId, newOwner)` to transfer control of the NFT account.  

## Events

- `NFTAccountCreated(uint256 indexed tokenId, address owner)` – Emitted when a new NFT account is minted.  
- `ERC20Transferred(uint256 indexed tokenId, address token, address to, uint256 amount)`  
- `ERC721Transferred(uint256 indexed tokenId, address token, uint256 tokenIdTransferred)`  
- `ERC1155Transferred(uint256 indexed tokenId, address token, uint256 id, uint256 amount)`  

## Notes

- This contract demonstrates **cutting-edge NFT composability** and is highly relevant for **DeFi, metaverse, and game development**.  
- Designed to be **audit-friendly, modular, and upgradeable**.  
- Compatible with wallets and tooling that support standard ERC721 NFTs.

