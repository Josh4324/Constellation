// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

//import "hardhat/console.sol";

/**
 * @title A ECO4Reward Contract
 * @author Joshua Adesanya
 * @notice This contract is for managing and rewarding environmental actions.
 */

contract ECO4Reward {
    // Errors
    error ECO__NotOwner();
    error ECO__NotAdmin();
    error ECO__InsufficientPoint();

    // State Variables
    address private ownerECO;
    uint256 private actionCount;
    uint256 private wasteCount;
    uint256 private treeCount;
    uint256 private userCount;
    uint256 private all_trees;
    uint256 private all_waste;
    uint256 private all_actions;
    uint256 private paid_out;
    uint256 private amount_donated;
    Users[] private all_users;

    struct Actions {
        uint256 id;
        string action_type;
        string description;
        string proof;
        bool status;
        bool confirmed;
        address creator;
    }

    struct Waste {
        uint256 id;
        uint256 weight; // kg;
        bool sorted;
        bool status;
        bool confirmed;
        address creator;
    }

    struct Trees {
        uint256 id;
        uint256 no_of_trees;
        string locations;
        bool status;
        bool confirmed;
        address creator;
    }

    struct Users {
        uint256 id;
        uint256 trees;
        uint256 waste;
        uint256 actions;
        uint256 overall_score;
        uint256 score;
        address user;
    } // Events

    event actionCreated(
        uint256 id, string action_type, string description, string proof, bool status, bool confirmed, address creator
    );

    event actionUpdated(uint256 id, bool status, bool confirmed, address creator);
    event wasteCreated(uint256 id, uint256 weight, bool sorted, bool status, bool confirmed, address creator);
    event wasteUpdated(uint256 id, bool status, bool confirmed, address creator);
    event treeCreated(uint256 id, uint256 no_of_trees, string locations, bool status, bool confirmed, address creator);
    event treeUpdated(uint256 id, bool status, bool confirmed, address creator);
    event userCreated(
        uint256 id, uint256 trees, uint256 waste, uint256 actions, uint256 overall_score, uint256 score, address user
    );
    event userUpdatedActions(uint256 actions, uint256 overall_score, uint256 score, address user);
    event userUpdatedWaste(uint256 waste, uint256 overall_score, uint256 score, address user);
    event userUpdatedTree(uint256 trees, uint256 overall_score, uint256 score, address user);
    event userUpdatedScore(uint256 score, address user);

    // Mappings
    mapping(address => bool) private adminToBool;
    mapping(address => bool) private usersList;
    mapping(address => Users) private usersData;
    mapping(uint256 => Actions) private idToActions;
    mapping(uint256 => Waste) private idToWaste;
    mapping(uint256 => Trees) private idToTrees;

    // Modifiers
    modifier onlyAdmin() {
        if (adminToBool[msg.sender] != true) revert ECO__NotAdmin();
        _;
    }

    modifier onlyOwnerECO() {
        if (ownerECO != msg.sender) revert ECO__NotOwner();
        _;
    }

    // Constructor

    constructor() {
        ownerECO = msg.sender;
        adminToBool[msg.sender] = true;
    }
}
