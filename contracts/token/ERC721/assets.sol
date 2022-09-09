// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721Upgradeable.sol";
import "./extensions/ERC721URIStorageUpgradeable.sol";
import "../../access/OwnableUpgradeable.sol";
import "../../proxy/utils/Initializable.sol";
import "../../utils/CountersUpgradeable.sol";

contract MyToken is Initializable, ERC721Upgradeable, ERC721URIStorageUpgradeable, OwnableUpgradeable {
    using CountersUpgradeable for CountersUpgradeable.Counter;

    CountersUpgradeable.Counter private _tokenIdCounter;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __ERC721_init("Asset", "ITM");
        __ERC721URIStorage_init();
        __Ownable_init();
    }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function updateURI(uint256 tokenId, string memory newTokenURI) public {
    require(
            _canMint(_msgSender()),
            "ERC721: Only contract owner can update NFT!"
        );
   // tokenIdToStat[tokenId] = newStats;
    _setTokenURI(tokenId, newTokenURI);
    }
}
