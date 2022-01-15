# retro-fier

Retrofier is a logic programming tool used for common-sense reasoning of the Retrosynthesis process.

Download the 'retrofier.lp' file.

Go to SWISH (A web based SWI-Prolog environment for implementation of Prolog) - https://swish.swi-prolog.org/

Open a new program and copy the 'retrofier.lp' code.

RUN queries on SWISH to check for the retrosynthesis reactions.

Input:

/* Set of reactions in the retrosysthesis process of a drug */

Example :

Drug - Abacavir

Reaction : A = B + C

C14H18N6O(Abacavir) = C11H12N5O + C3H6N

The molecule is represented using a dictionary with (key, value) as (<Atom symbol>, <Number of atoms>).
  
Reaction : A = B + C is repesented as list of molecules(dict).
  
Dict format for a molecule :  point{x: a, y : b, z : c, ...} where x,y,z are the atoms and a,b,c are number of atoms respectively. */


Run this command to check if the above retrosysnthesis reaction -
  
? retroFier([[point{c:14,h:18,n:6,o:1,l:0,f:0}, point{c:11,h:12,l:0,n:5,o:1,f:0}, point{c:3,h:6,n:1,o:0,l:0,f:0}]]).

