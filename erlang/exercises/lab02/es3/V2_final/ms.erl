-module(ms).
-export([start/1, to_slave/2, master/2, spawn_processes/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% START FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start(N) -> 
	io:format("GENERATOR OF BOTH MASTER AND SLAVES IS: ~p\n",[self()]),
	register(main,self()),
	Master=spawn(fun()->master([],N)end),
	register(master,Master),
	io:format("MASTER PROCESS IS: ~p \n",[Master]),
	receive
		{Slaves} -> io:format("MASTER GENERATED: ~p\n",[Slaves])
	end.
	
spawn_processes(N) when N==0 -> [];
spawn_processes(N) -> [spawn_link(fun()->slaves()end)|spawn_processes(N-1)].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MASTER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

restartprocess([El|Rest],Pid) when El==Pid -> [spawn_link(fun()->slaves()end)|restartprocess(Rest,Pid)]; 
restartprocess([El|Rest],Pid) -> [El|restartprocess(Rest,Pid)];
restartprocess([],_) -> [].

to_slave(Msg,N) -> master_rpc(main,{toslave,{N,Msg}}).
master_rpc(From,Msg) ->
	master!{From,Msg},
	receive
		{killed,SlavePid} -> io:format("Slave ~p has been killed. Restarting Service...",[SlavePid]);
		{SlavePid,Fuckingreply} -> io:format("Slave ~p received ~p \n",[SlavePid,Fuckingreply]);
		Any -> io:format("~p",[Any])
	end.

master(Slaves,N) ->
	case Slaves of
	[] -> 
		process_flag(trap_exit, true),
		Generated=spawn_processes(N),	
		main!{Generated},
		master(Generated,N);
	Slaves -> 
		receive
			%%%% STUFF RECEIVED FROM CLIENT %%%%
			{_From,{toslave,{S,M}}} -> sendslave(S,Slaves,M),master(Slaves,N);
			
			%%%% STUFF RECEIVED FROM SLAVES %%%%
			{ack,SlavePid,Msg} -> main!{SlavePid,Msg}, master(Slaves,N);
			{'EXIT',SlavePid,normal} -> main!{killed,SlavePid},master(restartprocess(Slaves,SlavePid),N)
		end
	end.	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SLAVES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

slave_rpc(From,To,Msg) -> To!{From,{Msg}}.
sendslave(S,Slaves,Msg) -> slave_rpc(master,(lists:nth(S,Slaves)),Msg).

slaves() -> 
	receive
	{_From,{die}} -> exit(normal);
	{From,{Msg}} -> From!{ack,self(),Msg},slaves()
	end.

