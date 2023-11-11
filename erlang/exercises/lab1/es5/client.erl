-module(client).
-export([start/0, dummy1/0, dummy2/0, dummy3/0, tot/0, stop/0]).

rpc(Server,Message)->
	Server!{self(),{Message}},
	receive
		Response -> Response
	after
		5000 -> {error,timeout}
	end.

start() ->
        Server=whereis(cserver),
	case Server of
	undefined -> 
		error_server_not_found;
	_ -> 
		{ok,Server}
	end.

dummy1() -> rpc(cserver,dummy1).
dummy2() -> rpc(cserver,dummy2).
dummy3() -> rpc(cserver,dummy3).
tot() -> rpc(cserver,tot).
stop() -> rpc(cserver,stop).
