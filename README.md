# Blockchain Group Assignment - Solidity Course

This repository is for the group laboratory assignment (5 members, 10% weighting).

## Team Members


## GitHub Contributors


## Assignment Requirements Coverage
- Course materials are stored in `materials/`.
- Course codebases are stored in `course-work/`.
- Progress/completion screenshots are stored in `screenshots/`.
- Supporting documentation is stored in `docs/`.

## Course Track
Chosen track: Alchemy University Learn Solidity

Course link:
https://www.alchemy.com/university/courses/solidity

## Contribution Rule
Every member must make public commits to this repository.

## Repository Structure
- `materials/` - notes, prompts, and allowed course resources
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Contract {
    function winningNumber(string calldata secretMessage) external returns(uint) {
        console.log(secretMessage);
        return 794;
    }
}- `course-work/` - Solidity practice and project code by module
- `screenshots/` - progress/completion screenshots by member
- `docs/` - checklist and planning documents

## Submission
- Deliverable: GitHub repository link
- Deadline: May 06, 2026
