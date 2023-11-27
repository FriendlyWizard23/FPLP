-module(ms).
-export([start/1, to_slave/2, master/3, spawn_processes/1, slaves/0]).

start(N) -> 
	io:format("GENERATOR OF BOTH MASTER AND SLAVES IS: ~p\n",[self()]),
	Slaves=spawn_processes(N),
	io:format("Stringed: ~p",[pids_to_strings(Slaves)]),
	Master=spawn(fun()->master([],N,self())end),
	io:format("MASTER PROCESS IS: ~p \n",[Master]),
	receive
		{Slaves} -> io:format("~p\n",[Slaves]);
		_->io:format("Not supported\n")
	end,
	ok.
	
pids_to_strings(Pids) ->
    lists:map(fun(Pid) -> pid_to_list(Pid) end, Pids).
spawn_processes(N) when N==0 -> [];
spawn_processes(N) -> [spawn_link(fun()->slaves()end)|spawn_processes(N-1)].
	

master(Slaves,N,Spawner) ->
	Slaves=spawn_processes(N),	
	Spawner!{pids_to_strings(Slaves)},
	ok.

slaves() -> ok.

to_slave(Msg,N) -> ok.
