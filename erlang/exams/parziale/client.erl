-module(client).
-export([start/0, do_reverse/1, stop/0]).

start()->
	global:register_name(client,self()),
	io:format("CLIENT PID: ~p \n",[self()]),
	mm:start('mm1@dreadz',mm1),
	mm:start('mm2@dreadz',mm2),
	server:start('server@dreadz').

client_rpc(From,To,Msg) ->
	global:whereis_name(To)!{From,{Msg}}.

do_reverse(List) ->
	{Part1,Part2} = partitionate_list(List),
	client_rpc(self(),mm1,Part1),
	client_rpc(self(),mm2,Part2),
	receive
        {Reply} -> io:format("Reply: ~p",[Reply])
        end.

partitionate_list(List) ->
	case (length(List) rem 2) of
	0 -> 
		lists:split((length(List) div 2 ), List);
	_ ->
		{List1,List2} = lists:split(((length(List) div 2 ) +1 ),List),
		{List1,([lists:nth(((length(List) div 2 ) +1),List1)|List2])}
	end.
		
stop() -> 
	io:format("Client Dying now...\n"),
	client_rpc(self(),mm1,stop),
	client_rpc(self(),mm2,stop),
	client_rpc(self(),server,stop).
