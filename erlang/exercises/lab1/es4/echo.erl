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
	{{my_server,stop}}-> 
		io:format("[ECHO]> stopped"),
		exit(stopped);
	{Message} -> 
		io:format("[ECHO]> ~p~n",[Message]),
		loop()
	end.

print(Message) -> rpc(Message), ok.
stop() -> rpc({my_server,stop}), ok.
