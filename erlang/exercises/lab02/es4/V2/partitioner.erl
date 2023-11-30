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

long_reversed_string(String) -> 
	io:format("INPUT STRING: ~p\n",[String]),
	client_to_master_rpc(self(),String).

check() -> client_to_master_rpc(self(),checkslaves).

client_to_master_rpc(From,Msg) ->
	master!{From,{Msg}},
	receive
		% PRINTING TO CLIENT THE REPLY OF MASTER
		{Reply} -> io:format("Master Reply: ~p",[Reply])	
	end.

master_loop(Slaves) ->
	receive
	%%% RECEIVING FROM CLIENT %%%
	{From,{checkslaves}} -> From!{Slaves},master_loop(Slaves);
	{From,{FuckingValue}} -> From!{load_manager(FuckingValue,Slaves,10,"")},master_loop(Slaves)
	%{From,{FuckingValue}} -> From!{FuckingValue},master_loop(Slaves)
	end.

send_partitioner([El],ParString,_)->slaves_rpc(master,El,ParString),[ParString];
send_partitioner([El|Rest],ParString,Size) ->
	slaves_rpc(master,El,string:substr(ParString,1,Size)),
	[string:substr(ParString,1,Size)|send_partitioner(Rest,string:substr(ParString,Size+1),Size)].

load_manager(LoadedString,Slaves,SyncNum,Merged) ->
	case SyncNum of
	10 -> send_partitioner(Slaves,LoadedString,(string:len(LoadedString) div 10)),load_manager(LoadedString,Slaves,SyncNum-1,Merged);
	-1 -> Merged;
	_ ->
		receive
		{SyncNum,ReversedPart} -> load_manager(LoadedString,Slaves,SyncNum-1,Merged++ReversedPart)
		end
	end.

slaves_rpc(From,To,Msg) ->
	To!{From,{Msg}}.

slaves(ServiceNumber) ->
	receive
	{From,{StringToManipulate}} ->
		io:format("Slave ~p received: ~p \n",[ServiceNumber,StringToManipulate]), 
		From!{ServiceNumber,lists:reverse(StringToManipulate)},
		slaves(ServiceNumber)
	end.
