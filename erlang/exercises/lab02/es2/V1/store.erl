-module(store).
-export([start/1, init/0]).

start(Node) -> 
	spawn(Node,fun()->init()end).

init() ->
	group_leader(whereis(user),self()),
	global:register_name(store,self()),
	io:format("Service spawned with PID: ~p and name: store\n",[self()]),
	loop().

loop() ->
	receive
		{From,{store,{Key,Value}}} -> 
			put(Key,Value),
			From!{stored},
			io:format("[Store]> RECEIVED STORE OF {~p,~p} FROM ~p\n",[Key,Value,From]),
			loop();
		{From,{lookup,{Key}}} ->
			From!{get(Key)},
			io:format("[Store]> RECEIVED LOOKUP OF {~p} FROM ~p\n",[Key,From]),
			loop()
	end. 
