-module(echo_client).
-export([start/0, print/1, stop/0]).

start() ->
	ServerPid = whereis(my_server),
	case ServerPid of
	undefined ->
		io:format("Server not found. Please start the server first.~n");
	_ ->
		Lpid=link(ServerPid),
		io:format("Connected to server.~n")
	end.

print(Message)->
	echo:print(Message).

stop()->
	exit(stopped).
