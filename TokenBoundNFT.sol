// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title TokenBoundNFT (ERC-6551 style)
/// @author Your Name
/// @notice Each NFT acts as a programmable on-chain wallet/account
contract TokenBoundNFT is ERC721, Ownable {
    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotNFTOwner();
    error TransferFailed();

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/

    mapping(uint256 => address) public accountOwner; // maps NFT ID → controlling wallet

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event NFTAccountCreated(uint256 indexed tokenId, address owner);
    event ERC20Transferred(uint256 indexed tokenId, address token, address to, uint256 amount);
    event ERC721Transferred(uint256 indexed tokenId, address token, uint256 tokenIdTransferred);
    event ERC1155Transferred(uint256 indexed tokenId, address token, uint256 id, uint256 amount);

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {}

    /*//////////////////////////////////////////////////////////////
                               MINTING
    //////////////////////////////////////////////////////////////*/

    function mint(address to, uint256 tokenId) external onlyOwner {
        _mint(to, tokenId);
        accountOwner[tokenId] = to;
        emit NFTAccountCreated(tokenId, to);
    }

    /*//////////////////////////////////////////////////////////////
                             ACCOUNT LOGIC
    //////////////////////////////////////////////////////////////*/

    /// @notice Send ERC20 from NFT account
    function sendERC20(uint256 tokenId, address token, address to, uint256 amount) external {
        require(msg.sender == accountOwner[tokenId], "Not NFT owner");
        bool success = IERC20(token).transfer(to, amount);
        if (!success) revert TransferFailed();
        emit ERC20Transferred(tokenId, token, to, amount);
    }

    /// @notice Send ERC721 from NFT account
    function sendERC721(uint256 tokenId, address token, uint256 nftId, address to) external {
        require(msg.sender == accountOwner[tokenId], "Not NFT owner");
        IERC721(token).transferFrom(address(this), to, nftId);
        emit ERC721Transferred(tokenId, token, nftId);
    }

    /// @notice Send ERC1155 from NFT account
    function sendERC1155(uint256 tokenId, address token, uint256 id, uint256 amount, bytes calldata data, address to) external {
        require(msg.sender == accountOwner[tokenId], "Not NFT owner");
        IERC1155(token).safeTransferFrom(address(this), to, id, amount, data);
        emit ERC1155Transferred(tokenId, token, id, amount);
    }

    /// @notice Update NFT account owner
    function updateAccountOwner(uint256 tokenId, address newOwner) external {
        require(msg.sender == accountOwner[tokenId], "Not NFT owner");
        accountOwner[tokenId] = newOwner;
    }
}
