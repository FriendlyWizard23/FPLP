-module(kvs).
-export([start/0, server/0, lookup/1, store/2]).

start() -> 
	Pid = spawn(?MODULE,server,[]),
	register(kvs,Pid).

rpc(Query) ->
	kvs!{self(),Query},
	receive
		{kvs,Reply} -> Reply
	end.
store(Key, Value) -> rpc({store,{Key,Value}}).
lookup(Key) -> rpc({lookup,{Key}}).
server()->
	receive
	{From, {store,{Key,Value}}} -> 
		put(Key, {ok,Value}),
		From!{kvs,ok},
		server();
	{From, {lookup,{Key}}} ->
		From!{kvs,get(Key)},
		loop
	end.

