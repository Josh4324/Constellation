// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "hardhat/console.sol";

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
    uint256 public userCount;
    uint256 private all_trees;
    uint256 private all_waste;
    uint256 private all_actions;
    uint256 private paid_out;
    uint256 private amount_donated;

    struct Action {
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

    struct Tree {
        uint256 id;
        uint256 no_of_trees;
        string locations;
        bool status;
        bool confirmed;
        address creator;
    }

    struct User {
        uint256 id;
        uint256 trees;
        uint256 waste;
        uint256 actions;
        uint256 overall_score;
        uint256 score;
        address user;
        uint256 last_action;
    }

    // Events
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
    event userUpdatedActions(uint256 id, uint256 actions, uint256 overall_score, uint256 score);
    event userUpdatedWaste(uint256 id, uint256 waste, uint256 overall_score, uint256 score);
    event userUpdatedTree(uint256 id, uint256 trees, uint256 overall_score, uint256 score);
    event userUpdatedScore(uint256 id, uint256 score);
    event userUpdatedOverScore(uint256 id, uint256 overall_score);

    // Mappings
    mapping(address => bool) public adminToBool;
    mapping(address => bool) private usersList;
    mapping(address => User) public usersData;
    mapping(uint256 => User) public userInfo;
    mapping(uint256 => Action) private idToActions;
    mapping(uint256 => Waste) private idToWaste;
    mapping(uint256 => Tree) private idToTrees;

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

    // External Functions

    /*
     * @notice Add an admin
     *  
     *  
     */
    function addAdmin(address user) external onlyOwnerECO {
        adminToBool[user] = true;
    }

    /*
     * @notice Register Environmental Action
     *  
     *  
     */
    function registerAction(string calldata action_type, string calldata desc, string calldata proof) external {
        idToActions[actionCount] = Action(actionCount, action_type, desc, proof, false, false, msg.sender);
        emit actionCreated(actionCount, action_type, desc, proof, false, false, msg.sender);
        actionCount++;
    }

    /*
     * @notice Evaluate Environmental Action
     *  
     *  
     */
    function confirmAction(uint256 id, uint256 score, bool status) external onlyAdmin {
        idToActions[id].status = status;
        idToActions[id].confirmed = true;
        if (usersList[idToActions[id].creator] != true) {
            usersList[idToActions[id].creator] = true;
            User memory newUser = User(userCount, 0, 0, 0, 0, 0, idToActions[id].creator, 0);
            usersData[idToActions[id].creator] = newUser;
            userInfo[userCount] = newUser;
            //all_users.push(newUser);
            emit userCreated(userCount, 0, 0, 0, 0, 0, idToActions[id].creator);
            userCount++;
        }

        if (status == true) {
            usersData[idToActions[id].creator].overall_score = usersData[idToActions[id].creator].overall_score + score;
            usersData[idToActions[id].creator].score = usersData[idToActions[id].creator].score + score;
            usersData[idToActions[id].creator].actions = usersData[idToActions[id].creator].actions + 1;

            userInfo[usersData[idToActions[id].creator].id].overall_score =
                userInfo[usersData[idToActions[id].creator].id].overall_score + score;

            userInfo[usersData[idToActions[id].creator].id].score =
                userInfo[usersData[idToActions[id].creator].id].score + score;

            userInfo[usersData[idToActions[id].creator].id].actions =
                userInfo[usersData[idToActions[id].creator].id].actions + 1;

            all_actions = all_actions + 1;
            emit userUpdatedActions(
                usersData[idToActions[id].creator].id,
                usersData[idToActions[id].creator].actions,
                usersData[idToActions[id].creator].overall_score,
                usersData[idToActions[id].creator].score
            );
        }

        usersData[idToActions[id].creator].last_action = block.timestamp;
        userInfo[usersData[idToActions[id].creator].id].last_action = block.timestamp;

        emit actionUpdated(id, status, true, idToActions[id].creator);
    }

    /*
     * @notice Register Waste Action
     *  
     *  
     */
    function registerWaste(uint256 weight, bool sorted) external {
        idToWaste[wasteCount] = Waste(wasteCount, weight, sorted, false, false, msg.sender);
        emit wasteCreated(wasteCount, weight, sorted, false, false, msg.sender);
        wasteCount++;
    }

    /*
     * @notice Evaluate Waste Action
     *  
     *  
     */
    function confirmWaste(uint256 id, uint256 score, bool status) external onlyAdmin {
        idToWaste[id].status = status;
        idToWaste[id].confirmed = true;

        if (usersList[idToWaste[id].creator] != true) {
            usersList[idToWaste[id].creator] = true;
            User memory newUser = User(userCount, 0, 0, 0, 0, 0, idToWaste[id].creator, 0);
            usersData[idToWaste[id].creator] = newUser;
            userInfo[userCount] = newUser;
            emit userCreated(userCount, 0, 0, 0, 0, 0, idToWaste[id].creator);
            userCount++;
        }

        if (status == true) {
            usersData[idToWaste[id].creator].overall_score = usersData[idToWaste[id].creator].overall_score + score;
            usersData[idToWaste[id].creator].score = usersData[idToWaste[id].creator].score + score;
            usersData[idToWaste[id].creator].waste = usersData[idToWaste[id].creator].waste + idToWaste[id].weight;

            userInfo[usersData[idToWaste[id].creator].id].overall_score =
                userInfo[usersData[idToWaste[id].creator].id].overall_score + score;

            userInfo[usersData[idToWaste[id].creator].id].score =
                userInfo[usersData[idToWaste[id].creator].id].score + score;

            userInfo[usersData[idToWaste[id].creator].id].actions =
                userInfo[usersData[idToWaste[id].creator].id].actions + 1;

            all_waste = all_waste + idToWaste[id].weight;

            emit userUpdatedWaste(
                usersData[idToWaste[id].creator].id,
                usersData[idToWaste[id].creator].waste,
                usersData[idToWaste[id].creator].overall_score,
                usersData[idToWaste[id].creator].score
            );
        }
        usersData[idToWaste[id].creator].last_action = block.timestamp;
        userInfo[usersData[idToWaste[id].creator].id].last_action = block.timestamp;
        emit wasteUpdated(id, status, true, idToWaste[id].creator);
    }

    /*
     * @notice Register Waste Action
     *  
     *  
     */
    function registerTrees(uint256 no_of_tress, string calldata locations) external {
        idToTrees[treeCount] = Tree(treeCount, no_of_tress, locations, false, false, msg.sender);
        emit treeCreated(treeCount, no_of_tress, locations, false, false, msg.sender);
        treeCount++;
    }

    /*
     * @notice Evaluate Waste Action
     *  
     *  
     */
    function confirmTress(uint256 id, uint256 score, bool status) external onlyAdmin {
        idToTrees[id].status = status;
        idToTrees[id].confirmed = true;

        if (usersList[idToTrees[id].creator] != true) {
            usersList[idToTrees[id].creator] = true;
            User memory newUser = User(userCount, 0, 0, 0, 0, 0, idToTrees[id].creator, 0);
            usersData[idToTrees[id].creator] = newUser;
            userInfo[userCount] = newUser;

            emit userCreated(userCount, 0, 0, 0, 0, 0, idToTrees[id].creator);
            userCount++;
        }

        if (status == true) {
            usersData[idToTrees[id].creator].overall_score = usersData[idToTrees[id].creator].overall_score + score;
            usersData[idToTrees[id].creator].score = usersData[idToTrees[id].creator].score + score;
            usersData[idToTrees[id].creator].trees = usersData[idToTrees[id].creator].trees + idToTrees[id].no_of_trees;

            userInfo[usersData[idToTrees[id].creator].id].overall_score =
                userInfo[usersData[idToTrees[id].creator].id].overall_score + score;

            userInfo[usersData[idToTrees[id].creator].id].score =
                userInfo[usersData[idToTrees[id].creator].id].score + score;

            userInfo[usersData[idToTrees[id].creator].id].actions =
                userInfo[usersData[idToTrees[id].creator].id].actions + 1;

            all_trees = all_trees + idToTrees[id].no_of_trees;

            emit userUpdatedTree(
                usersData[idToTrees[id].creator].id,
                usersData[idToTrees[id].creator].trees,
                usersData[idToTrees[id].creator].overall_score,
                usersData[idToTrees[id].creator].score
            );
        }
        usersData[idToTrees[id].creator].last_action = block.timestamp;
        userInfo[usersData[idToTrees[id].creator].id].last_action = block.timestamp;
        emit treeUpdated(id, status, true, idToTrees[id].creator);
    }

    /*
     * @notice Assign point to lottery winners
     *  
     *  
     */
    function addPoint(uint256 points, address user) external onlyAdmin {
        usersData[user].overall_score = usersData[user].overall_score + points;
        usersData[user].score = usersData[user].score + points;
        userInfo[usersData[user].id].overall_score = userInfo[usersData[user].id].overall_score + points;
        userInfo[usersData[user].id].score = userInfo[usersData[user].id].score + points;

        emit userUpdatedScore(usersData[user].id, usersData[user].score);
        emit userUpdatedOverScore(usersData[user].id, userInfo[usersData[user].id].overall_score);
    }

    /*
     * @notice Swap Points for Payment
     *  
     *  
     */
    function getPaid(uint256 points) external {
        if (points > usersData[msg.sender].score) {
            revert ECO__InsufficientPoint();
        }

        uint256 amount = points * 0.1 ether;

        usersData[msg.sender].score = usersData[msg.sender].score - points;

        emit userUpdatedScore(usersData[msg.sender].id, usersData[msg.sender].score);
        paid_out = paid_out + amount;

        (bool success,) = (msg.sender).call{value: amount}("");
        require(success, "Failed to send funds");
    }

    /*
     * @notice Donate or Add funds 4 ECOPROJECT
     *  
     *  
     */
    function donateOrFund() external payable {
        amount_donated = amount_donated + msg.value;
    }

    // Public Functions

    /*
     * @notice Get User Info
     *  
     *  
     */
    function getUserData(address user) public view returns (User memory) {
        return usersData[user];
    }

    /*
     * @notice Get User Info
     *  
     *  
     */
    function getUserInfo(uint256 id) public view returns (User memory) {
        return userInfo[id];
    }

    /*
     * @notice Get Contract Info
     *  
     *  
     */
    function getContractData() public view returns (uint256, uint256, uint256, uint256, uint256) {
        return (all_actions, all_waste, all_trees, userCount, paid_out);
    }
}
