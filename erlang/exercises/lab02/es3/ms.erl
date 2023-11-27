-module(ms).
-export([start/1, to_slave/2, master/2, spawn_processes/1]).

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
	
master_rpc(From,Msg) ->
	master!{From,Msg},
	receive
		{Reply} -> io:format("REPLY: ~p",[Reply])
	end.

slave_rpc(From,To,Msg) ->
	To!{From,{Msg}},
	receive
		{Pid,Reply,ack} -> {Pid,Reply,ack};
		{murdered} -> killed;
		Any -> Any;
		_ -> bad_arg
	end.

sendslave(S,Slaves,Msg) ->
	slave_rpc(self(),(lists:nth(S,Slaves)),Msg).

master(Slaves,N) ->
	case Slaves of
	[] -> 
		process_flag(trap_exit, true),
		Generated=spawn_processes(N),	
		main!{Generated},
		master(Generated,N);
	Slaves -> 
		receive
			{From,{toslave,{S,Msg}}} -> From!{sendslave(S,Slaves,Msg)};
			{From,_} -> From!{bad_structure}
		end
	end.
	

slaves() -> 
	receive
		{From,{die}} ->
			exit(normal);
		{From,{Msg}} -> 
			From!{self(),Msg,ack},
			slaves()
	end.

to_slave(Msg,N) -> 
	master_rpc(main,{toslave,{N,Msg}}).
