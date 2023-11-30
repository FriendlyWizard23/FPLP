-module(partitioner).
-export([start/0, master/0, slaves/1, check/0, long_reversed_string/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CLIENT FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start() ->
	register(main,self()),
	Pid=spawn(fun()->master() end),
	register(master,Pid),
	io:format("MASTER PROCESS IS: ~p\nMAIN PROCESS IS: ~p\n",[Pid,self()]),
	io:format("USAGE: partitioner:long_reversed_string('Your string here')\n").

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MASTER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

genprocesses(N) when N==0 ->[];
genprocesses(N) -> [spawn(fun()->slaves(10-N)end)|genprocesses(N-1)].

master() ->
	process_flag(trap_exit,true),
	master_loop(genprocesses(10)).

master_loop(Slaves) ->
	receive
	%%% RECEIVING FROM CLIENT %%%
	{From,{checkslaves}} -> From!{Slaves},master_loop(Slaves);
	{From,{FuckingValue}} -> From!{load_manager(FuckingValue,Slaves)},master_loop(Slaves)
	end.

load_manager(LoadedString,Slaves) ->
	send_partitioner(Slaves,LoadedString,(string:len(LoadedString) div 10)),
	load(LoadedString,Slaves,9,"").

load(LoadedString,Slaves,SyncNum,Merged) ->
	case SyncNum of
	-1 -> Merged;
	_ ->
		receive
		{SyncNum,ReversedPart} -> load(LoadedString,Slaves,SyncNum-1,Merged++ReversedPart)
		end
	end.


send_partitioner([El],ParString,_)->slaves_rpc(master,El,ParString),[ParString];
send_partitioner([El|Rest],ParString,Size) ->
	slaves_rpc(master,El,string:substr(ParString,1,Size)),
	[string:substr(ParString,1,Size)|send_partitioner(Rest,string:substr(ParString,Size+1),Size)].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SLAVES FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

slaves_rpc(From,To,Msg) ->
	To!{From,{Msg}}.

slaves(ServiceNumber) ->
	receive
	{From,{StringToManipulate}} ->
		From!{ServiceNumber,lists:reverse(StringToManipulate)},
		slaves(ServiceNumber)
	end.
