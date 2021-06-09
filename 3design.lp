%Create list of feasible symbols (list of natural numbers)
sym(A) :- A=1..v.

%Tdesigns have a known number of blocks.
%This value is equivalent to lambda0_0 value
block(A) :- A = 1..l00.

%Open for interpretation pairs of triples to be in blocks
l30 {cw(A,B,C,N) : block(N)} l30 :- A<B, B<C, sym(A),sym(B),sym(C).

%value V is in row R
rv(V,R) :- cw(A,B,C,R), A=V, sym(A), sym(B), sym(C).
rv(V,R) :- cw(A,B,C,R), B=V, sym(A), sym(B), sym(C).
rv(V,R) :- cw(A,B,C,R), C=V, sym(A), sym(B), sym(C).

%value V is not in row R
nrv(V,R) :- not rv(V,R), sym(V), block(R).

%number of blocks containing V1 but not V2.
intersectiononeone(V1,V2,N) :- N = #count{R : rv(V1,R), nrv(V2,R) }, sym(V1), sym(V2), V1 < V2.
:- not intersectiononeone(V1,V2,l11), sym(V1), sym(V2), V1 < V2.

%number of blocks containing V1 but not V2 or V3.
intersectiononetwo(V1,V2,V3,N) :- N = #count{R : rv(V1,R), nrv(V2,R), nrv(V3,R) }, sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.
:- not intersectiononetwo(V1,V2, V3, l12), sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.

%Ensures each block contains k values
hw(R,N) :- N = #count{V : rv(V,R)}, block(R).
:- not hw(R,k), block(R).

%Ensures each value V is in exactly N blocks
containspoint(V,N) :- N = #count{R : rv(V,R)}, sym(V).
:- not containspoint(V,l10), sym(V).

%Ensures values V1 and V2 are in exactly N blocks
containspointsvv(V1,V2, N) :- N = #count{R : rv(V1,R), rv(V2,R)}, sym(V1), sym(V2), V1<V2.
:- not containspointsvv(V1,V2,l20), sym(V1), sym(V2), V1<V2.

%Ensures each value V is not in exactly N blocks.
doesnotcontain(V,N) :- N = #count{R : nrv(V,R)}, sym(V).
:- not doesnotcontain(V,l00-l10), sym(V).

%number of blocks containing V1 V2 but not V3.
intersectiontwoone(V1,V2,V3,N) :- N = #count{R : rv(V1,R), rv(V2,R), nrv(V3,R) }, sym(V1), sym(V2), sym(V3),  V1 < V2, V2 < V3.
:- not intersectiontwoone(V1,V2, V3, l21), sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.
#show cw/4.
#show containspoint/2.
#show doesnotcontain/2.
#show intersectiononeone/3.
