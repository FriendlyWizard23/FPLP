-module(hypercube).
-export([create/0, init/1]).

create()->
	P=spawnprocesses(gray:cube()),

spawnprocesses([]) -> [];
spawnprocesses([El|Rest])->[{El,spawn(fun()->init(El)end)}|spawnprocesses(Rest)].


getPID(_Find,[])->not_found;
getPID(Find,[{Node,PID}|Rest]) when Find==Node -> PID;
getPID(Find,[{Node,PID}|Rest]) -> getPID(Find,Rest).

init(Name)->
	io:format("The process labeled ~p just started ~n",[gray:parse(Name)]),
	loop(Name,[]).

loop(Name,Neighbours) ->
	receive
	{From,{Msg}} -> From!{Msg};
	{From,{discover,{Node,Pid}}} -> loop(Name,[{Node,Pid}|Neighbours])
	end.
