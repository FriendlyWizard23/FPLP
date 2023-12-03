-module(bank).
-export([start/0, init/0]).

start()->
	ServerPid=spawn('bank@dreadz',fun()->init()end),
	global:register_name(bank@dreadz,ServerPid).
init() ->
	group_leader(whereis(user),self()),
	io:format("[Bank]> Spawned bank at ~p~n",[self()]),
	loop(5000,0,0).

loop(Max,Balance,GlobalSeq)->
	receive
	{_From,deposit,{DName,DSeq,Amount}} when (Balance+Amount)>Max -> 
		io:format("I got a deposit of ~p from ~p (local msg ~p global msg ~p)~n",[Amount,DName,DSeq,GlobalSeq]),
		loop(Max,Max,GlobalSeq+1);
	{_From,deposit,{DName,DSeq,Amount}} -> 
		io:format("I got a deposit of ~p from ~p (local msg ~p global msg ~p)~n",[Amount,DName,DSeq,GlobalSeq]),
		loop(Max,(Balance+Amount),(GlobalSeq+1));
	{_From,withdraw,{DName,DSeq,Amount}} when (Balance-Amount)<1 ->
		io:format("I got a withdraw of ~p from ~p (local msg ~p global msg ~p)~n",[Amount,DName,DSeq,GlobalSeq]),
                loop(Max,(0),(GlobalSeq+1));
	{_From,withdraw,{DName,DSeq,Amount}}->
		io:format("I got a withdraw of ~p from ~p (local msg ~p global msg ~p)~n",[Amount,DName,DSeq,GlobalSeq]),
                loop(Max,(Balance-Amount),(GlobalSeq+1));
	{From,balance,{DName,DSeq}} ->
		io:format("I got a balance from ~p (local msg ~p global msg ~p)~nBalance is ~p and i received from: ~p~n",[DName,DSeq,GlobalSeq,Balance,From]),
		From!{Balance},
                loop(Max,Balance,(GlobalSeq+1))
	end.
