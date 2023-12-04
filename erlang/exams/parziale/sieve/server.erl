-module(server).
-export([start/1]).

start(N)->
	spawn(server@dreadz,fun()->init(N)end).
	

init(N)->
	ServerPid=self(),
	FirstSieve=sieve:start('sieve@dreadz',1,N,ServerPid),
	global:register_name(server,self()),
	group_leader(whereis(user),self()),
	loop(N,FirstSieve,global:whereis_name(client)).

loop(N,FirstSieve,Client)->
	io:format("Server ~p waiting...~n",[self()]),
	receive
	{From,new,Num} -> 
		io:format("You asked for ~p~n",[Num]), 
		FirstSieve!{new,Num},
		loop(N,FirstSieve,From);
	
	{res,R} -> 
		io:format("Replying to ~p~n",[Client]),
		Client!{result,R},
		loop(N,FirstSieve,Client);

	Any -> io:format("Received shit~p~n",[Any])
	end.
