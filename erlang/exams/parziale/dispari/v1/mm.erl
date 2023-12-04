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
		sendString(NewString,ServerNode,Name,0),loop(Name)	
	end.
	
mm_server_rpc(ServerNode,Message)->
	io:format("I am sending ~p to the server~n",[Message]),
	ServerNode!Message,
	io:format("I am waiting for the other mm now..~n"),
	receive
	{From,{oktogo}} -> ok
	end.

sendString([],ServerNode,MMName,_Counter)->
	mm_server_rpc(ServerNode,{self(),{MMName,finished}}),	
	[];

sendString([El|Rest],ServerNode,MMName,Counter) ->
	mm_server_rpc(ServerNode,{self(),{Counter,MMName,El}}),
	El++sendString(Rest,ServerNode,MMName,Counter+1).
	
		
	


