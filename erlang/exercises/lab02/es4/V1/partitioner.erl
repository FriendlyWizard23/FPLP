-module(partitioner).
-export([start/0, master/0, slaves/1, check/0, long_reversed_string/1]).

start() ->
	register(main,self()),
	Pid=spawn(fun()->master() end),
	register(master,Pid),
	io:format("MASTER PROCESS IS: ~p\nMAIN PROCESS IS: ~p\n",[Pid,self()]).

genprocesses(N) when N==0 ->[];
genprocesses(N) -> [spawn(fun()->slaves(10-N)end)|genprocesses(N-1)].

master() ->
	process_flag(trap_exit,true),
	master_loop(genprocesses(10)).

long_reversed_string(String) -> client_to_master_rpc(self(),String).
check() -> client_to_master_rpc(self(),checkslaves).

client_to_master_rpc(From,Msg) ->
	master!{From,{Msg}},
	receive
		% PRINTING TO CLIENT THE REPLY OF MASTER
		{Reply} -> io:format("Master Reply: ~p",[Reply]);
		{reversed,Reply} -> io:format("Reversed Text: ~p",[order_and_merge(Reply)])	
	end.

master_loop(Slaves) ->
	receive
	%%% RECEIVING FROM CLIENT %%%
	{From,{checkslaves}} -> From!{Slaves},master_loop(Slaves);
	{From,{String}} -> From!{reversed,load_manager(String,Slaves,[],10)},master_loop(Slaves)
	end.

send_partitioner([],_,_)->[];
send_partitioner([El|Rest],String,Size) ->
	slaves_rpc(master,El,string:substr(String,1,Size)),
	[string:substr(String,1,Size)|send_partitioner(Rest,string:substr(String,Size+1),Size)].

load_manager(_String,_Slaves,Map,Counter) when Counter==0 -> Map;
load_manager(String,Slaves,Map,Counter) ->
	send_partitioner(Slaves,String,(string:len(String) div 10)),
	receive
	{SyncNum,ReversedPart} -> load_manager(String,Slaves,[{SyncNum,ReversedPart}|Map],Counter-1)
	end.

slaves_rpc(From,To,Msg) ->
	To!{From,{Msg}}.

order_and_merge(Lista) ->
	SortedList = lists:sort(fun({A, _}, {B, _}) -> A >= B end, Lista),
	Concatenated = lists:foldl(fun({_Num, Str}, Acc) -> Acc ++ Str end, "", SortedList),
	Concatenated.

slaves(ServiceNumber) ->
	receive
	{From,{StringToManipulate}} -> 
		From!{ServiceNumber,lists:reverse(StringToManipulate)},
		slaves(ServiceNumber)
	end.
