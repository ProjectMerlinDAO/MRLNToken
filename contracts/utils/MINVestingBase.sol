// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./MINStructs.sol";
import "../token/MINToken.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title MINVestingBase
 * @dev This contract handles the vesting schedule for the MIN token.
 */
abstract contract MINVestingBase is Ownable {
    using MINStructs for MINStructs.VestingSchedule;

    // Mapping of beneficiary addresses to their vesting schedules
    mapping(address => MINStructs.VestingSchedule) private _vestingSchedules;

    // The MIN token
    MINToken private immutable _token;

    /**
     * @dev Sets the MIN token and the owner of the contract.
     * @param token The MIN token.
     */
    constructor(MINToken token) Ownable(msg.sender) {
        _token = token;
    }

    /**
     * @dev Modifier to make a function callable only by beneficiaries.
     */
    modifier onlyBeneficiary() {
        require(_vestingSchedules[msg.sender].beneficiary == msg.sender, "MINVesting: caller is not a beneficiary");
        _;
    }

    /**
     * @dev Returns the vesting schedule for a beneficiary.
     * @param beneficiary The address of the beneficiary.
     * @return The vesting schedule of the beneficiary.
     */
    function getVestingScheduleForBeneficiary(
        address beneficiary
    ) public view returns (MINStructs.VestingSchedule memory) {
        return _vestingSchedules[beneficiary];
    }

    /**
     * @dev Releases the vested tokens to the beneficiary.
     * @param amount The amount of tokens to release.
     */
    function release(uint256 amount) public onlyBeneficiary {
        uint256 releasableAmount = computeReleasableAmount(msg.sender);
        require(releasableAmount > 0, "MINVesting: no tokens are due");
        require(releasableAmount >= amount, "MINVesting: amount exceeds releasable amount");
        MINStructs.VestingSchedule storage vestingSchedule = _vestingSchedules[msg.sender];
        vestingSchedule.releasedAmount += amount;

        _token.transfer(msg.sender, amount);
    }

    /**
     * @dev Computes the amount of tokens that can be released to a beneficiary.
     * @param beneficiary The address of the beneficiary.
     * @return The amount of tokens that can be released.
     */
    function computeReleasableAmount(address beneficiary) public view virtual returns (uint256) {
        require(_vestingSchedules[beneficiary].beneficiary == beneficiary, "MINVesting: beneficiary not found");
        MINStructs.VestingSchedule storage vestingSchedule = _vestingSchedules[beneficiary];
        uint256 currentTime = getCurrentTime();
        uint256 releasable = 0;
        uint256 tgeAmount = 0;
        //calculate tge, if tge is zero, then no tokens are due
        if (vestingSchedule.tgePermille > 0) {
            tgeAmount = (vestingSchedule.totalAmount * vestingSchedule.tgePermille) / 1000;
            releasable += tgeAmount;
        }
        if (currentTime < vestingSchedule.startTimestamp + vestingSchedule.cliffDuration) {
            return releasable;
        } else if (
            currentTime >=
            vestingSchedule.startTimestamp + vestingSchedule.cliffDuration + vestingSchedule.vestingDuration
        ) {
            releasable = vestingSchedule.totalAmount - vestingSchedule.releasedAmount;
            return releasable;
        } else {
            uint256 timeFromStart = currentTime - (vestingSchedule.startTimestamp + vestingSchedule.cliffDuration);
            // Division before multiplication is intentional to floor the result.
            uint256 vestedSlicePeriods = timeFromStart / vestingSchedule.slicePeriodSeconds;
            uint256 vestedSeconds = vestedSlicePeriods * vestingSchedule.slicePeriodSeconds;
            // Compute the amount of tokens that are vested.
            uint256 vestedAmount = ((vestingSchedule.totalAmount - tgeAmount) * vestedSeconds) /
                vestingSchedule.vestingDuration;
            // Subtract the amount already released and return.
            releasable += vestedAmount - vestingSchedule.releasedAmount;
        }
        return releasable;
    }

    /**
     * @dev Returns the current time.
     * @return The current timestamp in seconds.
     */
    function getCurrentTime() internal view virtual returns (uint256) {
        return block.timestamp;
    }

    /**
     * @dev Returns the MIN token.
     * @return The MIN token.
     */

    function getToken() public view returns (IERC20) {
        return _token;
    }

    ///
    /// @dev Since it's an abstract, no need for onlyOwner modifier
    /// @param vestingSchedule The vesting schedule to set.

    function setVestingSchedule(MINStructs.VestingSchedule memory vestingSchedule) public {
        _vestingSchedules[vestingSchedule.beneficiary] = vestingSchedule;
    }

    function getVestingSchedule(address beneficiary) public view returns (MINStructs.VestingSchedule memory) {
        return _vestingSchedules[beneficiary];
    }
}
