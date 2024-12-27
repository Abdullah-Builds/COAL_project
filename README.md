# Tic-Tac-Toe Game - Assembly Project

This is a console-based Tic-Tac-Toe game developed in **x86 Assembly**. Below is a brief explanation of the key features and functionality of the game.

## Features
- **Player Interaction**: Two players take turns to play with "X" and "O".
- **Game Rules**: 
  - Players choose positions from 1 to 9 on a 3x3 board.
  - The game ends when a player wins or if there is a draw.
- **Colorful Output**: The game uses different colors to highlight different sections (game rules, players’ scores, etc.).
- **Player Switching**: After each move, the current player switches between 'X' and 'O'.
- **Score Tracking**: The game keeps track of wins for both players across multiple rounds.

## Key Components
- **Game Board**: 
  - The board is displayed as a 3x3 grid, with positions numbered from 1 to 9.
- **Game Logic**: 
  - After each turn, the game checks if a player has won or if the board is full (draw).
- **Input Handling**: 
  - Players input a number (1-9) to place their marker, with invalid inputs prompting the player to try again.
- **Replay Option**: 
  - The user can play multiple rounds, with a prompt asking how many times they wish to play.

## Instructions
1. **Start the Game**: The game welcomes you with a message and instructions.
2. **Make a Move**: Enter a number from 1 to 9 to place your marker.
3. **Game Outcome**: The game announces the winner after each round or if there is a draw.
4. **Scores**: At the end of each round, the scores of 'X' and 'O' are displayed.
5. **Exit**: To quit, press `0` during your turn.

## Credits
- **Abdul Ahad** (23k-0590)
- **Rayyan Ur Rehman** (23k-0634)
- **Muhammad Abdullah Khan** (23k-0607)

## Project Setup
This project requires an **assembly environment** to run. The main logic is based on x86 Assembly and uses basic I/O functions to interact with the user.

---

Thank you for playing!
