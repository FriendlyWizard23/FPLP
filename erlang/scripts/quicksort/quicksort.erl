 -module(quicksort).
-export([quicksort/1]).

bigger(_Cmp, []) -> [];
bigger(Cmp, [El|Rest]) when El>Cmp -> [El | bigger(Cmp,Rest)];
bigger(Cmp, [_El | Rest]) -> bigger(Cmp, Rest).

smaller(_Cmp, []) -> [];
smaller(Cmp, [El | Rest]) when El =< Cmp -> [El | smaller(Cmp, Rest)];
smaller(Cmp, [_El | Rest]) -> smaller(Cmp, Rest).

quicksort([])->[];
quicksort([Pivot|Rest]) -> quicksort(smaller(Pivot, Rest)) ++ [Pivot] ++ quicksort(bigger(Pivot, Rest)).
