-module(client).
-export([start/0, store/2, lookup/1]).

start() ->
	Spid=whereis(kvs),
	case Spid of
		undefined -> io:fwrite("[client]> Server not ready. Shutting down: ");
		_ -> io:fwrite("[client]> Server Ready: ")
	end.

store(Key,Value) -> rpc:call(server@dreadz,kvs,store,[Key,Value]).
lookup(Key) -> rpc:call(server@dreadz,kvs,lookup,[Key]).
