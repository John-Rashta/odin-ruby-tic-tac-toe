BOARD
PLAYER
GAMEITSELF

ALL CLASSES
BOARD INSTANCE VARIABLE FOR EMPTY BOARD
JUST CHOOSE WHO PLAYS BY TURN- INTERNAL VARIABLE FOR IT
play with 2 numbers- line, column example (2, 1) remove all white space
use ternarys to check whose turn it is and who won to fetch the correct player
IF slot to play.empty? do the play otherwise dont
Class board should return nil if move is illegal
REST PUBLIC methods are making a move/playing the game, restarting game, resetting
players- rest private methods for helping play the game
restarting game is just clear board and turns to 1
resetting requires names for players
playing game checks whose turn it is, makes the move, if its nil puts error message
otherwise shows new board
need to track available spaces in board/or just use turns- when its end
of turn 9 show its a draw
if either number is 1 and both numbers arent 1 than diagonal check isnt necessary
maybe a predicate method that just checks all 3 spots have same symbol x == spot1
and spot 1 == spot2
maybe a method for checking, diagonal, vertical, horizontal wins- 3 methods
maybe put them in a module? and include it in game class