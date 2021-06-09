sym(A) :- A=1..v.
block(A) :- A = 1..l00.
l30 {cw(A,B,C,N) : block(N)} l30 :- A<B, B<C, sym(A),sym(B),sym(C).

%:- cw(A,B,C,N1), cw(A,B,C,N2), N1!= N2, block(N1), block(N2).

%value D is in row R
rv(D,R) :- cw(A,B,C,R), A=D, sym(A), sym(B), sym(C).
rv(D,R) :- cw(A,B,C,R), B=D, sym(A), sym(B), sym(C).
rv(D,R) :- cw(A,B,C,R), C=D, sym(A), sym(B), sym(C).

%value D is not in row R
nrv(D,R) :- not rv(D,R), sym(D), block(R).

%number of blocks containing V1 but not V2.
intersectiononeone(V1,V2,N) :- N = #count{R : rv(V1,R), nrv(V2,R) }, sym(V1), sym(V2), V1 < V2.
:- not intersectiononeone(V1,V2,l11), sym(V1), sym(V2), V1 < V2.

%number of blocks containing V1 but not V2 or V3.
intersectiononetwo(V1,V2,V3,N) :- N = #count{R : rv(V1,R), nrv(V2,R), nrv(V3,R) }, sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.
:- not intersectiononetwo(V1,V2, V3, l12), sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.

%Ensures each block contains k values
hw(R,N) :- N = #count{D : rv(D,R)}, block(R).
:- not hw(R,k), block(R).

%Ensures each value D is in exactly N blocks
containspoint(D,N) :- N = #count{R : rv(D,R)}, sym(D).
:- not containspoint(D,l10), sym(D).

%Ensures values V1 and V2 are in exactly N blocks
containspointsvv(V1,V2, N) :- N = #count{R : rv(V1,R), rv(V2,R)}, sym(V1), sym(V2), V1<V2.
:- not containspointsvv(V1,V2,l20), sym(V1), sym(V2), V1<V2.


%Ensures each value D is not in exactly N blocks.
doesnotcontain(D,N) :- N = #count{R : nrv(D,R)}, sym(D).
:- not doesnotcontain(D,l00-l10), sym(D).


%number of blocks containing V1 V2 but not V3.
intersectiontwoone(V1,V2,V3,N) :- N = #count{R : rv(V1,R), rv(V2,R), nrv(V3,R) }, sym(V1), sym(V2), sym(V3),  V1 < V2, V2 < V3.
:- not intersectiontwoone(V1,V2, V3, l21), sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.
#show cw/4.
#show containspoint/2.
#show doesnotcontain/2.
#show intersectiononeone/3.
