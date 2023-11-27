-module(store).
-export([start/2, loop/0, store/3, lookup/2]).

start(Node,Registername) -> 
	Pid=spawn(Node,fun()->loop()end),
	register(Registername,Pid),
	io:format("Service spawned at ~p with PID: ~p and name: ~p",[Node,Pid,Registername]),
	ok.

loop() ->
	receive
		{From,{store,{Key,Value}}} -> 
			put(Key,Value),
			From!{stored},
			loop();
		{From,{lookup,{Key}}} ->
			From!{get(Key)},
			loop()
	end. 

rpc(Service,Query) ->
	Service!{self(),Query},
	receive
		{Reply} -> Reply
	end.

store(Service,Key,Value) -> rpc(Service,{store,{Key,Value}}).
lookup(Service,Key) -> rpc(Service,{lookup,{Key}}).
