-module(area).
-export([area/0, rpc/2, start/0]).

start()->spawn(area,area,[]).

rpc(Pid,Request) ->
	Pid!{self(),Request},
	receive
		{Pid,Response} -> Response
	end.

area()->
	receive
	{From, {square,X}} ->From ! {self(), X*X};
	{From,{rectangle,X,Y}} ->From ! {self(), X*Y};
	{From,{circle,R}} -> From ! {self(), 3.14159*R*R};
	{From,{Other}} -> From ! {self(), {error,Other}}
	end,
	area().
