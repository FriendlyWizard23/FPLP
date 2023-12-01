-module(client).
-export([start/0, lookup/1, store/2]).

start() -> 
	Ping=net_adm:ping('store@dreadz'),
	case Ping of
	pong ->	
		io:format("Store is at: ~p\n",[global:whereis_name(store)]),
		io:format("You are ~p\n ",[self()]);
	_ -> io:format("Ping Failure: ~p\n",[Ping]),exit(kill)
	end.

client_rpc(From,To,Msg) ->
	global:whereis_name(To)!{From,Msg},
	receive
	{Reply} -> io:format("[~p]> ~p\n",[self(),Reply])
	end.		

lookup(Key) ->
	client_rpc(self(),store,{lookup,{Key}}).

store(Key,Value) ->
	client_rpc(self(),store,{store,{Key,Value}}).
