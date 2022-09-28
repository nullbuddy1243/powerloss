// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// import '@0xsequence/erc-1155/contracts/tokens/ERC1155/ERC1155.sol';
// import "@0xsequence/erc-1155/contracts/interfaces/ERC1155.sol";

contract ChubaPowerLoss is ERC1155, Ownable {
    string public baseURI;
    string public name;
    string public ticker;
    mapping(address => mapping(uint256 => uint256)) internal balances;
    mapping(address => mapping(address => bool)) internal operators;

    constructor(
        string memory _name,
        string memory _uri,
        string memory _ticker
    ) ERC1155("") {
        name = _name;
        baseURI = _uri;
        ticker = _ticker;
    }

    function setURI(string memory newuri) public onlyOwner {
        baseURI = newuri;
    }

    function _setContractName(string memory _newName) internal {
        name = _newName;
    }

    function uri(uint256 _id) public view override returns (string memory) {
        return
            string(
                // abi.encodePacked(baseURI, Strings.toString(_id) )
                bytes.concat(
                    bytes(baseURI),
                    bytes(Strings.toString(_id)),
                    ".json"
                )
            );
    }

    function balanceOf(address _owner, uint256 _id)
        public
        view
        override
        returns (uint256)
    {
        return balances[_owner][_id];
    }

    function mint(address account, uint256 id) public onlyOwner {
        _mint(account, id);
    }

    function _mint(address _to, uint256 _id) internal {
        balances[_to][_id] = balances[_to][_id] + 1;

        // Emit event
        emit TransferSingle(msg.sender, address(0x0), _to, _id, 1);

        // Calling onReceive method if recipient is contract
        // _callonERC1155Received(address(0x0), _to, _id, _amount, gasleft(), _data);
    }

    //     /***********************************|
    //   |         Operator Functions        |
    //   |__________________________________*/

    //     /**
    //      * @notice Enable or disable approval for a third party ("operator") to manage all of caller's tokens
    //      * @param _operator  Address to add to the set of authorized operators
    //      * @param _approved  True if the operator is approved, false to revoke approval
    //      */
    //     function setApprovalForAll(address _operator, bool _approved)
    //         external
    //         override
    //     {
    //         // Update operator status
    //         operators[msg.sender][_operator] = _approved;
    //         emit ApprovalForAll(msg.sender, _operator, _approved);
    //     }

    //     /**
    //      * @notice Queries the approval status of an operator for a given owner
    //      * @param _owner     The owner of the Tokens
    //      * @param _operator  Address of authorized operator
    //      * @return isOperator True if the operator is approved, false if not
    //      */
    //     function isApprovedForAll(address _owner, address _operator)
    //         public
    //         view
    //         override
    //         returns (bool isOperator)
    //     {
    //         return operators[_owner][_operator];
    //     }
}
