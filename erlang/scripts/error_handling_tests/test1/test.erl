-module(test).
-export([start/0, speak/1, speaktome/0]).

on_exit(Pid,Fun) ->
        spawn(fun() ->
                process_flag(trap_exit,true),
                link(Pid),
                receive
                        {'EXIT',Pid,Why} -> Fun(Why)
                end
        end).

start() ->
	Pid=spawn(test,speaktome,[]),
	register(crasher,Pid),
	process_flag(trap_exit,true),
	link(Pid),
	on_exit(Pid,fun(Why) -> io:format("~p died with:~p~n",[Pid, Why])end). 

speaktome() ->
	receive
		{From,{kill}} -> exit(kill);
		{From,{X}} -> From!{list_to_atom(X)}
	end,
	speaktome().

speak(Msg) ->
	crasher!{self(),{Msg}},
	receive
		{R} -> R
	end.


