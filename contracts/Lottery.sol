// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import {VRFCoordinatorV2Interface} from "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import {VRFConsumerBaseV2} from "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import {AutomationCompatibleInterface} from
    "@chainlink/contracts/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol";
import "./ECO.sol";

/**
 * @title A ECO4Reward Lottery Contract
 * @author Joshua Adesanya
 * @notice This contract is for the gamification of the ECO4REWARD contract.
 */

contract ECO4RewardLotteryDaily is VRFConsumerBaseV2, AutomationCompatibleInterface {
    // Errors
    error ECO__UpkeepNotNeeded();
    error ECO__TransferFailed();

    /* State variables */
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;
    uint256 public lottery_time;
    address public s_recentWinner;
    ECO4Reward ECO;

    // Events
    event RequestedWinner(uint256 indexed requestId);
    event WinnerPicked(address indexed player);

    constructor(
        address ecoaddress,
        uint64 subscriptionId,
        bytes32 gasLane,
        uint32 callbackGasLimit,
        address vrfCoordinatorV2
    ) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_subscriptionId = subscriptionId;
        i_gasLane = gasLane;
        i_callbackGasLimit = callbackGasLimit;
        ECO = ECO4Reward(ecoaddress);
        lottery_time = block.timestamp;
    }

    function getDailyLotteryUsers() public view returns (ECO4Reward.User[] memory) {
        uint256 currentIndex = 0;
        uint256 itemCount = 0;

        for (uint256 i = 0; i < ECO.userCount(); i++) {
            if (block.timestamp - ECO.getUserInfo(i).last_action < 24 hours) {
                itemCount += 1;
            }
        }

        ECO4Reward.User[] memory items = new ECO4Reward.User[](itemCount);

        for (uint256 i = 0; i < ECO.userCount(); i++) {
            if (block.timestamp - ECO.getUserInfo(i).last_action < 24 hours) {
                uint256 currentId = i;

                items[currentIndex] = ECO.getUserInfo(currentId);

                currentIndex += 1;
            }
        }

        return items;
    }

    /**
     * @notice Check if there are users who have created an environmental action today with Chainlink Automation Network
     * @return upkeepNeeded signals if there are users
     */
    function checkUpkeep(bytes calldata) public view override returns (bool upkeepNeeded, bytes memory performData) {
        ECO4Reward.User[] memory ListBool = getDailyLotteryUsers();
        upkeepNeeded = (ListBool.length > 0 && (block.timestamp > lottery_time + 10 minutes));

        return (upkeepNeeded, "0x0");
    }

    /**
     * @notice Called by Chainlink Automation Node
     */
    function performUpkeep(bytes calldata /* performData */ ) external override {
        uint256 requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane, i_subscriptionId, REQUEST_CONFIRMATIONS, i_callbackGasLimit, NUM_WORDS
        );

        lottery_time = block.timestamp;
        emit RequestedWinner(requestId);
    }

    /**
     * @dev This is the function that Chainlink VRF node
     * calls to send the money to the random winner.
     */
    function fulfillRandomWords(uint256, /* requestId */ uint256[] memory randomWords) internal override {
        ECO4Reward.User[] memory ListOfUsers = getDailyLotteryUsers();
        uint256 indexOfWinner = randomWords[0] % ListOfUsers.length;
        address recentWinner = ListOfUsers[indexOfWinner].user;
        s_recentWinner = recentWinner;
        ECO.addPoint(10, recentWinner);
    }
}
