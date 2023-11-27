-module(client).
-export([connect/1, hit/1]).

rpc(Pid,Msg) ->
	Pid!{self(),{Msg}},
	receive
		{Reply} -> Reply
	end.

connect(Server) -> rpc(Server,connect).
hit(Server) -> rpc(Server,hit).	
