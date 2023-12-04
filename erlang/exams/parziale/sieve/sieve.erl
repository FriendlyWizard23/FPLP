-module(sieve).
-export([start/4, getNthPrime/1]).

%% FIRST NODE NEEDS TO HAVE ALSO THE SPAWNER OF IT TO SEND MSG BACK
start(Node,1,Tot,Spawner)-> spawn_link(Node,fun()->init(1,Tot,self(),Spawner)end).

%% OTHER SIEVES THAT ARE NOT FIRST
start(SeqN,Tot,First) when SeqN==Tot+1-> First;
start(SeqN,Tot,First) -> spawn_link(fun()->init(SeqN,Tot,First)end).

getNthPrime(N) -> getNthPrime(N,0,0).
getNthPrime(N,N,Counter) ->Counter-1;
getNthPrime(N,Found,Counter) ->
	case isPrime(Counter) of
	true-> getNthPrime(N,Found+1,Counter+1);
	false->getNthPrime(N,Found,Counter+1)
	end.

isPrime(1)->false;
isPrime(N)->isPrime(2,N).
isPrime(N,N)->true;
isPrime(Counter,N) when N rem Counter == 0 ->false;
isPrime(Counter,N)->isPrime(Counter+1,N).

init(SeqN,Tot,First,Spawner) ->
	group_leader(whereis(user),self()),
	Next=start(SeqN+1,Tot,First),
	Identifier=getNthPrime(SeqN),
	io:format("[Sieve]> Generated Sieve with SEQ: ~p PID: ~p and IDENTIFIER: ~p and NEXT ~p SPAWNER IS: ~p~n",[SeqN,self(),Identifier,Next,Spawner]),
	loop(SeqN,First,Next,Identifier,Spawner,unknown).

init(SeqN,Tot,First) ->
	group_leader(whereis(user),self()),
	Next=start(SeqN+1,Tot,First),
	Identifier=getNthPrime(SeqN),
	io:format("[Sieve]> Generated Sieve with SEQ: ~p PID: ~p and IDENTIFIER: ~p and NEXT ~p FIRST IS: ~p~n",[SeqN,self(),Identifier,Next,First]),
	loop(SeqN,First,Next,Identifier).

% LOOP FOR THE FIRST SIEVE MUST BE DIFFERENT FROM OTHERS!
loop(SeqN,First,Next,Identifier,Spawner,LoopedN) ->
	receive
	%% HAS LOOPED
	{pass,LoopedN} ->
		io:format("Received looped message~n"),
		First!{res,true},
		loop(SeqN,First,Next,Identifier,Spawner,unknown);		
	
	%% FILTERED
	{pass,N} when (N rem Identifier == 0) ->
		io:format("[First]> Filtered ~p~n",[N]),
		First!{res,false},
		loop(SeqN,First,Next,Identifier,Spawner,unknown);
	
	%% MUST PASS
	{new,N} ->
		io:format("[First]> Passing ~p~n",[N]), 
		Next!{pass,N},
		loop(SeqN,First,Next,Identifier,Spawner,N);
	
	%% RETURN CORRECT MESSAGE
	{res,true}->
		io:format("[First]> Ok no one filtered it!~n"),
		Spawner!{res,true},
		loop(SeqN,First,Next,Identifier,Spawner,unknown);
	
	%% RECEIVED FILTERED MESSAGE
	{res,false}->
		io:format("[First]> Received filtered message. Sending to ~p~n",[Spawner]),
		Spawner!{res,false},
		loop(SeqN,First,Next,Identifier,Spawner,unknown)
	end. 

% LOOP FOR THE OTHER SIEVES THAT ARE NOT FIRST
loop(SeqN,First,Next,Identifier)->
	receive
	
	%% FILTERED
	{pass,N} when (N rem Identifier == 0) -> 
		io:format("[Sieve ~p]> Filtered ~p Sending to ~p~n",[Identifier,N,First]),
		First!{res,false},
		loop(SeqN,First,Next,Identifier);
	
	%% MUST PASS
	{pass,N} -> 
		io:format("[Sieve ~p]> Passing ~p~n",[Identifier,N]), 
		Next!{pass,N},
		loop(SeqN,First,Next,Identifier)
	end.

































