# retro-fier

Retrofier, developed in Prolog, is a logic programming tool we developed to apply common-sense reasoning for verifying to reactions identified by Retrosynthesis process


## Steps to run the program
1. We used SWISH (A web based SWI-Prolog environment for implementation of Prolog) - https://swish.swi-prolog.org/ for developing and executing our program
2. Download the 'retrofier.lp' file
3. Load the downloaded file on to SWISH platform (you can also use locally installed and set up swi/prolog tools)
4. Execute `retroFier(<input>)` in the SWISH run environment (Please see below for input format).

## Input format

The inputs to this program are reactions identified as a result of Retrosynthetic analysis in the form of nested lists.
We used Prolog's dictionary format to represent the molecules: point{x: a, y : b, z : c, ...} where x,y,z are the atoms and a,b,c are corresponding number of atoms respectively.
Let dict(X) denote this representation for molecule X.
Consider the following reaction steps to reach compound A

A = B + C 

B = X + Y

X = P + Q

The input in this case would be [[dict(A), dict(B), dict(C)], [dict(B), dict(X), dict(Y)], [dict(X), dict(Y), dict(Z)]].

Drug - Abacavir

C14H18N6O(Abacavir) = C11H12N5O + C3H6N
  

Example:

Run this command to check if the above retrosysnthesis reaction -

?- retroFier([[point{c:14,h:18,n:6,o:1,l:0,f:0}, point{c:11,h:12,l:0,n:5,o:1,f:0}, point{c:3,h:6,n:1,o:0,l:0,f:0}]]).
