-module(server).
-export([start/2]).

start(Node,Name)->
	spawn(Node,fun()->init(Name)end).

init(Name)->
	io:format("[Server]> Server Started at ~p~n",[self()]),
	global:register_name(Name,self()),
	group_leader(whereis(user),self()),
	loop(0,0,0,0,true).

middleman_rpc(Middleman,Msg)->
	Ping=net_adm:ping(list_to_atom(atom_to_list(Middleman)++"@dreadz")),
	io:format("[Server]> Sending ~p to ~p with PID ~p Pinging Result is~p~n",[Msg,Middleman,global:whereis_name(Middleman),Ping]),
	global:whereis_name(Middleman)!{self(),{Msg}}.

loop(finished,finished,_CurEl1,_CurEl2,IsPalindroma)->
	IsPalindroma;

loop(CounterMM1,CounterMM2,CurEl1,CurEl2,_IsPalindroma) when CounterMM1==CounterMM2,CurEl1/=CurEl2->
	io:format("[Server]> ~p and ~p are different, therefore not palindrome!~n",[CurEl1,CurEl2]),
	receive
	%% RECEIVING NORMAL STUFF
	{_From,{CounterMM1,mm1,Char}}->loop(CounterMM1+1,CounterMM2,Char,CurEl2,false);
	{_From,{CounterMM2,mm2,Char}}->loop(CounterMM1,CounterMM2+1,CurEl1,Char,false)
	end;

loop(CounterMM1,CounterMM2,CurEl1,CurEl2,_IsPalindroma)->
	io:format("[Server]> Receiving...~n"),
	receive
	%% RECEIVING END OF STREAM

	{_From,{finished,mm1}} -> 
		io:format("[Server]> Received finished From mm1~n"),
		middleman_rpc(mm2,oktogo),
		loop(finished,CounterMM2,CurEl1,CurEl2,_IsPalindroma);
	{_From,{finished,mm2}} -> 
		io:format("[Server]> Received finished From mm2~n"),
		middleman_rpc(mm1,oktogo),
		loop(CounterMM1,finished,CurEl1,CurEl2,_IsPalindroma);

	%% RECEIVING NORMAL STUFF
	{_From,{CounterMM1,mm1,Char}}->
		io:format("[Server]> Received ~p from mm1. Now waiting for mm2~n",[Char]),
		middleman_rpc(mm2,oktogo),
		loop(CounterMM1+1,CounterMM2,Char,CurEl2,_IsPalindroma);
	{_From,{CounterMM2,mm2,Char}}->
		io:format("[Server]> Received ~p from mm2. Now waiting for mm1~n",[Char]),
		middleman_rpc(mm1,oktogo),	
		loop(CounterMM1,CounterMM2+1,CurEl1,Char,_IsPalindroma)
	end.
	
