-module(server).
-export([start/2]).

start(Node,Name)->
	spawn(Node,fun()->init(Name)end).

init(Name)->
	io:format("[Server]> Server Started at ~p~n",[self()]),
	global:register_name(Name,self()),
	group_leader(whereis(user),self()),
	loop(unknown,unknown,mm1,0,0,0,true).

loop(MM1PID,MM2PID,mm1,CounterMM1,CounterMM2,PrevElement,IsPalindroma)->
	%io:format("~n[Server]> mm1 with CounterMM1 ~p and CounterMM2 ~p is waiting for message..~n",[CounterMM1,CounterMM2]),
	receive
	{From,{CounterMM1,mm1,Char}} -> 
		io:format("[Server]> Received ~p from mm1 and CounterMM1 is~p~n",[Char,CounterMM1]),
		loop(From,MM2PID,mm2,CounterMM1+1,CounterMM2,Char,IsPalindroma);
	{From,{CounterMM1,mm1,finished}} ->
		io:format("[Server]> Received finish signal from mm1~n"),
		loop(From,MM2PID,mm2,CounterMM1,CounterMM2,PrevElement,IsPalindroma)
	end;

loop(MM1PID,MM2PID,mm2,CounterMM1,CounterMM2,PrevElement,IsPalindroma)->
	%io:format("~n[Server]> mm2 with CounterMM2 ~p and CounterMM1 ~p is waiting for message..~n",[CounterMM2,CounterMM1]),
	receive
	{From,{CounterMM2,mm2,finished}} -> 
		io:format("[Server]> Received finish message, result is: ~p~n",[IsPalindroma]),
		MM1PID!{finished,IsPalindroma},
		MM2PID!{finished,IsPalindroma},
		loop(MM1PID,From,mm1,0,0,0,true);
	{From,{CounterMM2,mm2,Char}} when PrevElement/= Char -> 
		io:format("[Server]> Received ~p from mm2 which is different from ~p --> NOT PALINDROME!~n",[Char,PrevElement]),
		loop(MM1PID,From,mm1,CounterMM1,CounterMM2+1,Char,false); 
	{From,{CounterMM2,mm2,Char}} ->
		io:format("[Server]> Received ~p from mm2 which is equal to ~p and CounterMM2 is~p~n",[Char,PrevElement,CounterMM2]),
		loop(MM1PID,From,mm1,CounterMM1,CounterMM2+1,Char,IsPalindroma)			
		
	end.

