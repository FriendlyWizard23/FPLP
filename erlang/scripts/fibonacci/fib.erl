-module(fib).
-export([fibonacci_sequence/1]).

fibonacci(N) when N==0 -> 0;
fibonacci(N) when N==1 -> 1;
fibonacci(N) when N>1 -> fibonacci(N-1)+fibonacci(N-2). 

fibonacci_seq(N,IND,L) when IND==N -> lists:reverse(L);
fibonacci_seq(N,IND,L) when IND<N -> fibonacci_seq(N,IND+1,[fibonacci(IND)|L]).

fibonacci_sequence(N) -> fibonacci_seq(N,0,[]).
