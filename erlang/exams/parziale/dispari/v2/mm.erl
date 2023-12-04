-module(mm).
-export([start/2, init/1]).

start(Node,Name)->
	spawn(Node,fun()->init(Name)end).

init(Name) ->
	group_leader(whereis(user),self()),
	Ping=net_adm:ping(server@dreadz),
	io:format("~n[~p]> Ping Reply ~p~n",[Name,Ping]),
	io:format("[~p]> Discovered Server: ~p~n",[Name,global:whereis_name(server)]),
	global:register_name(Name,self()),
	loop(Name).

loop(Name)->
	io:format("[~p]> Started with PID ~p.. waiting now~n",[Name,self()]),
	receive
	%% RECEIVING FROM CLIENT STRING TO SEND TO SERVER
	{From,ServerNode,{newstring,NewString}} ->
		io:format("[~p]> Received String ~p~n",[Name,NewString]),
		sendString(NewString,ServerNode,Name,0),
		receive
		{finished,Value} -> io:format("[~p] Received Result: ~p~n",[Name,Value]),From!{Value}
		end,
		loop(Name)
	end.
	
mm_server_rpc(ServerNode,Message)->
	io:format("I am sending ~p to the server~n",[Message]),
	ServerNode!Message.

sendString([],ServerNode,MMName,Counter)->
	mm_server_rpc(ServerNode,{self(),{Counter,MMName,finished}}),	
	ok;

sendString([El|Rest],ServerNode,MMName,Counter) ->
	mm_server_rpc(ServerNode,{self(),{Counter,MMName,El}}),
	sendString(Rest,ServerNode,MMName,Counter+1).
	
		
	


