%Create list of feasible symbols (list of natural numbers)
sym(A) :- A=1..v.

%Tdesigns have a known number of blocks.
%This value is equivalent to lambda0_0 value
blocknum(A) :- A = 1..l00.

%Open for interpretation pairs of triples to be in blocks
%l30 {cw(A,B,C,N) : block(N)} l30 :- A<B, B<C, sym(A),sym(B),sym(C).

1 {block(V1,V2,V3,V4,N) : V1<V2, V2<V3, V3<V4, sym(V1), sym(V2), sym(V3), sym(V4) } 1 :- blocknum(N).

rv(V,R) :- block(V1,V2,V3,V4,R), V1=V, sym(V1), sym(V2), sym(V3), sym(V4).
rv(V,R) :- block(V1,V2,V3,V4,R), V2=V, sym(V1), sym(V2), sym(V3), sym(V4).
rv(V,R) :- block(V1,V2,V3,V4,R), V3=V, sym(V1), sym(V2), sym(V3), sym(V4).
rv(V,R) :- block(V1,V2,V3,V4,R), V4=V, sym(V1), sym(V2), sym(V3), sym(V4).

:- block(V1,V2,V3,V4,N1), block(V1,V2,V3,V4,N2), N1 != N2.
%value V is not in row R
nrv(V,R) :- not rv(V,R), sym(V), blocknum(R).

three(V1,V2,V3, N) :- N = #count{R : rv(V1,R), rv(V2,R), rv(V3,R)}, V1<V2, V2<V3, sym(V1), sym(V2), sym(V3).
:- not three(V1,V2,V3,l30), V1<V2, V2<V3, sym(V1), sym(V2), sym(V3).

%number of blocks containing V1 but not V2.
intersectiononeone(V1,V2,N) :- N = #count{R : rv(V1,R), nrv(V2,R) }, sym(V1), sym(V2), V1 < V2.
:- not intersectiononeone(V1,V2,l11), sym(V1), sym(V2), V1 < V2.

%number of blocks containing V1 but not V2 or V3.
intersectiononetwo(V1,V2,V3,N) :- N = #count{R : rv(V1,R), nrv(V2,R), nrv(V3,R) }, sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.
:- not intersectiononetwo(V1,V2, V3, l12), sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.

%Ensures each block contains k values
%hw(R,N) :- N = #count{V : rv(V,R)}, blocknum(R).
%:- not hw(R,k), blocknum(R).

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
%intersectiontwoone(V1,V2,V3,N) :- N = #count{R : rv(V1,R), rv(V2,R), nrv(V3,R) }, sym(V1), sym(V2), sym(V3),  V1 < V2, V2 < V3.
%:- not intersectiontwoone(V1,V2, V3, l21), sym(V1), sym(V2), sym(V3), V1 < V2, V2 < V3.
#show block/5.
%#show three/4.
%#show blockcount/1.
%#show containspoint/2.
%#show doesnotcontain/2.
%#show intersectiononeone/3.
