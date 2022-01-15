%molecule(point{c:6,n:2,o:3,h:4}).

% Dichlorodiphenyltrichloroethane - DDT
%toxic(point{c:14,l:5,h:9}).

%toxic(point{c:6,l:6,h:6}).
%toxic(point{}).
%toxic(point{}).

toxic(X):- X.c>=6, X.l>=4.
toxic(X):- X.c=(4*Y)+2, X.h=(2*Y)+4.

organicCompound(X):- X.c>=2.

isValidRxn([X, Y, Z|[]]):-
    organicCompound(X), X.c is Y.c+Z.c, X.n is Y.n+Z.n, X.o is Y.o+Z.o, X.h is Y.h+Z.h, X.f is Y.f+Z.f, not(isToxic(X)), not(isToxic(Y)), not(isToxic(Z)).

isToxic(X):- toxic(X).

isCommercial([_,B,C|[]]):- member(B, [point{c:8,h:3,n:1,o:2,l:1,f:0}, point{c:11,h:12,l:1,n:5,o:1}, point{c:3,h:6,n:1,o:0,l:0}, point{c:4,h:9,n:2,o:0,l:0,f:0}, point{c:6,h:6,n:0,o:1,l:0,f:0}]),
    member(C, [point{c:8,h:3,n:1,o:2,l:1,f:0}, point{c:11,h:12,l:1,n:5,o:1}, point{c:3,h:6,n:1,o:0,l:0}, point{c:4,h:9,n:2,o:0,l:0,f:0}, point{c:6,h:6,n:0,o:1,l:0,f:0}]).


isValidPlan([]).
% [[A, B, C], [B, X, Y], [X, Y, Z]]
isValidPlan([H|T]):-
    isValidRxn(H),
    isValidPlan(T).

%check([H|T]):-
%    isValidPlan([H|T]),
%    isCommercial(last(T, Last)).

check([_|T]) :-
      T = [_],
      isCommercial(T).

check([_|T]) :-
     T \= [_];
     check(T).

retroFier([H|T]):-
    isValidPlan([H|T]).
    check([H|T]).

% Positive examples
% Abacavir: drug
% [[point{c:14,h:18,n:6,o:1,l:0,f:0}, point{c:11,h:12,l:1,n:5,o:1,f:0}, point{c:3,h:6,n:1,o:0,l:0,f:0}]]

% Afatinib: drug
% C24H25ClFN5O3 = C18H21ClN4O3 + C6H4N
% C18H21ClN4O3 = C12H12ClN3O2 + C6H9N1O1
% C12H12ClN3O2 = C8H3ClFN3O2 + C4H9FN2 (2-Fluoropiperazine)
% point{c:8,h:3,n:1,o:2,l:1,f:1}
% [[point{c:24,h:25,n:5,o:3,l:1,f:1}, point{c:18,h:21,n:4,o:3,l:1,f:0}, point{c:6,h:4,n:1,o:0,l:0,f:1}],
% [point{c:18,h:21,n:4,o:3,l:1,f:0}, point{c:12,h:12,n:3,o:2,l:1,f:0}, point{c:6,h:9,n:1,o:1,l:0,f:0}],
% [point{c:12,h:12,n:3,o:2,l:1,f:0}, point{c:8,h:3,n:1,o:2,l:1,f:0}, point{c:4,h:9,n:2,o:0,l:0,f:0}]]

%[[point{c:24,h:25,n:5,o:3,l:1,f:1}, point{c:18,h:21,n:4,o:3,l:1,f:0}, point{c:6,h:4,n:1,o:0,l:0,f:1}], [point{c:18,h:21,n:4,o:3,l:1,f:0}, point{c:12,h:12,n:3,o:2,l:1,f:0}, point{c:6,h:9,n:1,o:1,l:0,f:0}], [point{c:12,h:12,n:3,o:2,l:1,f:0}, point{c:8,h:3,n:1,o:2,l:1,f:0}, point{c:4,h:9,n:2,o:0,l:0,f:0}]]

% Counter example
% Aspirin: drug
% C9H8O4 = C2H4O (c2h2o) + C7H6O3
% C7H6O3 = CO2 + C6H6O(phenol - commercially available)
% [[point{c:9,h:8,n:0,o:4,l:0,f:0}, point{c:2,h:2,n:0,o:1,l:0,f:0}, point{c:7,h:6,n:0,o:3,l:0,f:0}],
%  [point{c:7,h:6,n:0,o:3,l:0,f:0}, point{c:1,h:0,n:0,o:0,l:0,f:0}, point{c:6,h:6,n:0,o:1,l:0,f:0}]]


% Negative examples
% [[point{c:18,h:14}, point{c:14,h:10}, point{c:4,h:4}]]

% [[point{c:18,h:14,l:0,f:0,o:0,n:0}, point{c:14,h:10,l:0,f:0,o:0,n:0}, point{c:4,h:4,l:0,f:0,o:0,n:0}],
% [point{c:14,h:10,l:0,f:0,o:0,n:0}, point{c:14,l:5,h:9,f:0,o:0,n:0}, point{c:0,h:1,l:0,f:0,o:0,n:0}]]

% C16H11N3O3  = C10H7N2O + C6H5NO2 = C14H21OF3 + NH2
% [[point{c:16,h:11,n:3,o:3,l:0,f:0}, point{c:10,h:7,n:2,o:1,l:0,f:0}, point{c:6,h:4,n:1,o:2,l:0,f:0}],                                                                                                              % point[{c:10,h:7,n:2,o:1,l:0,f:0}, qq]]

%isValidPlan([[point{c:14,h:18,n:6,o:1,l:0}, point{c:11,h:12,l:1,n:5,o:1}, point{c:3,h:6,n:1,o:0,l:0}]]).

