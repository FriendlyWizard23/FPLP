-module(exe3).
-export([nth/2]).

nth(N,[_|Rest]) when N>1 -> nth(N-1,Rest);
nth(1,[El1|_]) -> El1;
nth(_, []) -> not_found.
