-module(client).
-export([start/0,is_palindroma/1]).

start()->
	group_leader(whereis(user),self()),
	Server=server:start(server@dreadz,server),
	MM1=mm:start(mm1@dreadz,mm1),
	MM2=mm:start(mm2@dreadz,mm2),
	global:register_name(mm1,MM1),
	global:register_name(mm2,MM2),
	global:register_name(serevr,Server).

is_palindroma(String)->
	Server=global:whereis_name(server),
	MM1=global:whereis_name(mm1),
	MM2=global:whereis_name(mm2),
	io:format("[Client]>MM1: ~p, MM2: ~p, Server: ~p~n",[MM1,MM2,Server]),
	{First,Second}=splitter(String),
	MM1!{self(),Server,{newstring,First}},
	MM2!{self(),Server,{newstring,lists:reverse(Second)}},
	receive
		{true} -> io:format("The String ~p is palindrome~n",[String]);
		{false} -> io:format("The String ~p is not palindrome~n",[String])
	end.

splitter(String)->
	case (length(String) rem 2) of
	0 ->	lists:split((length(String) div 2),String);
	_ ->	{First,Second} = lists:split((length(String) div 2), String),
		{First++[lists:nth(1,Second)],Second}
	end.
		
