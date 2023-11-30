-module(mm).
-export([start/2, loop_manager/1]).

start(Node,Name) ->
	Pid=spawn(Node,fun()->loop_manager(Name)end),
	io:format("GENERATED PID: ~p\n",[Pid]),
	link(Pid).

loop_manager(ServiceName) ->
	group_leader(whereis(user),self()),
	global:register_name(ServiceName,self()),
	io:format("Spawned ~p and now registed with name ~p. Linked with: ~p\n",[self(),ServiceName,global:whereis_name(client)]),
	loop(ServiceName).

loop(ServiceName) ->
	io:format("~p is listening...\n",[ServiceName]),
	Info = erlang:process_info(self(), links),
	io:format("Il processo ~p è linkato a ~p~n\n", [self(), Info]),
	receive
	{_From,{stop}} -> io:format("Dying now...\n");
	{From,{List}} -> sendListValues(lists:reverse(List),ServiceName,global:whereis_name(server),From),loop(ServiceName)
	end.

mm_rpc(To,Value,ServiceName,From) ->
	io:format("~p sta inviando ~p al server\n",[ServiceName,Value]),
	To!{From,{ServiceName,Value}}.

sendListValues([],ServiceName,To,From) ->
	mm_rpc(To,finished,ServiceName,From);

sendListValues([El|Rest],ServiceName,To,From)->
	mm_rpc(To,El,ServiceName,From),
	sendListValues(Rest,ServiceName,To,From).
	
