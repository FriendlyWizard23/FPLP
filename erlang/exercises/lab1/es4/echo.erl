-module(echo).
-export([start/0, print/1, stop/0, loop/0]).

start() -> 
	CurPid = spawn(?MODULE,loop,[]),
	register(my_server,CurPid),
	ok.

rpc(Message) -> 
	my_server!{Message}.

loop() ->
	receive
	{stop}-> 
		io:format("[ECHO]> stopped"),
		exit(stopped);
	{{msg,Message}} -> 
		io:format("[ECHO]> ~p~n",[Message]),
		loop()
	end.

print(Message) -> rpc({msg,Message}), ok.
stop() -> rpc(stop), ok.

