-module(mainproc).
-export([start/0, loop/0, rpc/2]).

start() -> spawn(mainproc,loop,[]). 
rpc(Pid,Message) -> Pid!{Message}.
loop() ->
	receive
	{terminate} -> 
		io:format("Process number: ~p has been: ~p~n", [self(), terminated]), 
		exit(normal);
	{Message} -> 
		io:format("Process number: ~p says: ~p~n\n", [self(), Message]), 
		loop()
	end.
