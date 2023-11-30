-module(server).
-export([start/1, loop_manager/0]).

start(Node) ->
	Pid=spawn(Node,fun()->loop_manager()end),
	link(Pid).

loop_manager() ->
	group_leader(whereis(user),self()),
	io:format("Spawned process ~p and now registered with name ~p \n",[self(),server]),
	global:register_name(server,self()),
	loop([],[],false,false,unknown).	
	
loop(List1,List2,true,true,ComingFrom)->
	io:format("Server has finished: ~p\n",[List2++List1]), 
	ComingFrom!{List2++List1},
	loop([],[],false,false,unknown);

loop(List1,List2,Finished1,Finished2,_ComingFrom) ->	
	io:format("server is listening...\n"),
	receive
	{From,{mm1,finished}} -> 
		io:format("[Server]> mm1 EOT\n"),
		loop(List1,List2,true,Finished2,From);
	{From,{mm2,finished}} -> 
		io:format("[Server]> mm2 EOT\n"),
		loop(List1,List2,Finished1,true,From);
	{From,{mm1,Value}} -> 
		io:format("[Server]> Received ~p from mm1\n",[Value]),
		loop(List1++[Value],List2,Finished1,Finished2,From);
	{From,{mm2,Value}} -> 
		io:format("[Server]> Received ~p from mm2\n",[Value]),
		loop(List1,List2++[Value],Finished1,Finished2,From);
	{_From,{stop}} ->
		io:format("[Server]> It was an honour, dying now\n");
	Any -> 
		io:format("[Server]> Received unknown string: ~p ",[Any]),
		loop(List1,List2,Finished1,Finished2,unknown)
	end.
