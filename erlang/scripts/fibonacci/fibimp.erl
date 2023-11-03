-module(fibimp).
-export([fib_seq/1]).

fib_seq(N,L,N) -> L;
fib_seq(N,[El1,El2|Rest],IX) -> fib_seq(N,[El1+El2,El1|[El2|Rest]],IX+1).

fib_seq(N) -> lists:reverse(fib_seq(N,[1,0],2)).
