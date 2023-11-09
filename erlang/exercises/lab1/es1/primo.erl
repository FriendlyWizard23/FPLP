-module(primo).
-export([is_palindroma/1,anagrams/2,factors/1, perfect/1, sumall/1]).

invert([]) -> [];
invert([El|Rest])->invert(Rest) ++ [El].
is_palindroma(String) -> String==invert(String).

greater([],_)->[];
greater([El|Rest],Ref) when El>Ref -> [El]++greater(Rest,Ref);
greater([_|Rest],Ref) -> greater(Rest,Ref).
smaller([],_)->[];
smaller([El|Rest],Ref) when El=<Ref -> [El]++smaller(Rest,Ref);
smaller([_|Rest],Ref) -> smaller(Rest,Ref).
quicksort([])->[];
quicksort([Pivot|Rest]) -> quicksort(smaller(Rest,Pivot))++[Pivot]++quicksort(greater(Rest,Pivot)).

sortel([])->[];
sortel([El|Rest])->[quicksort(El)|sortel(Rest)].

is_anagram(_,[],_) -> [];
is_anagram(Parola,[El|Rest],[El2|Rest2]) when Parola==El2-> [El]++is_anagram(Parola,Rest,Rest2);
is_anagram(Parola,[_|Rest],[_|Rest2]) -> is_anagram(Parola,Rest,Rest2).

anagrams(Parola,List) -> is_anagram(quicksort(Parola),List,sortel(List)).

is_prime(_,1) -> true;
is_prime(N,C) when N rem C == 0 -> false;
is_prime(N,C) -> is_prime(N,C-1). 

is_prime(1) -> true;
is_prime(N) -> is_prime(N,N-1).

factors(1,_)->[1];
factors(N,C) when N rem C == 0 -> case is_prime(C) of true ->[C|factors(N div C ,N div C)]; _ -> factors(N,C-1) end;
factors(N,C) -> factors(N,C-1).

factors(1) -> [];
factors(N) -> factors(N,N).

divisors(N,0) -> [];
divisors(N,C) when N rem C == 0 -> [C|divisors(N,C-1)];
divisors(N,C) -> divisors(N,C-1).
divisors(N) -> divisors(N,N-1).


sumall([]) -> 0;
sumall([El|Rest]) -> El+sumall(Rest).
perfect(N) -> N == sumall(divisors(N)).
