-module(gray).
-export([neighbours/1, cube/0, parse/1]).
parse([]) -> [];
parse([El|Rest]) -> integer_to_list(El)++parse(Rest).

neighbours([Fi, Se, Th, Fo]) ->
	[
		[Fi]++[Se]++[Th]++[invert(Fo)],
		[Fi]++[Se]++[invert(Th)]++[Fo],
		[Fi]++[invert(Se)]++[Th]++[Fo],
		[invert(Fi)]++[Se]++[Th]++[Fo]
	].

invert(El) when El==49 ->48;
invert(_El) -> 49.	
	
cube() -> 
	["0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"].
