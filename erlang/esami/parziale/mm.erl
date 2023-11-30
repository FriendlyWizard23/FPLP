-module(mm).
-export([start/2, loop_manager/1]).

start(Node,Name) ->
	spawn_link(Node,fun()->loop_manager(Name)end).

loop_manager(ServiceName) ->
	group_leader(whereis(user),self()),
	global:register_name(ServiceName,self()),
	io:format("Spawned ~p and now registed with name ~p. Linked with: ~p\n",[self(),ServiceName,global:whereis_name(client)]),
	loop(ServiceName).

loop(ServiceName) ->
	io:format("~p is listening...\n",[ServiceName]),
	receive
	{_From,{die}} -> exit(normal);
	{From,{List}} -> sendListValues(lists:reverse(List),ServiceName,global:whereis_name(server),From),loop(ServiceName);
	{'EXIT',Pid,Why} -> io:format("Dying now...\n"), exit(Why)
	end.

mm_rpc(To,Value,ServiceName,From) ->
	io:format("~p sta inviando ~p al server\n",[ServiceName,Value]),
	To!{From,{ServiceName,Value}}.

sendListValues([],ServiceName,To,From) ->
	mm_rpc(To,finished,ServiceName,From);

sendListValues([El|Rest],ServiceName,To,From)->
	mm_rpc(To,El,ServiceName,From),
	sendListValues(Rest,ServiceName,To,From).
	
