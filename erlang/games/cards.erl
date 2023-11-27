-module(cards).
-export([new_card/2, card_value/1]).

new_card(Value,Seed) when Value>=1, Value=<10 orelse Value==jack orelse Value==queen orelse Value==king orelse Value==ace, Seed==hearts orelse Seed==spades orelse Seed==clubs orelse Seed==diamonds-> {Value,Seed};
new_card(_,_)->bad_arg.

card_value({Value,_Seed}) when Value>=1,Value=<10 -> Value;
card_value({_Value,_Seed}) -> 10.
