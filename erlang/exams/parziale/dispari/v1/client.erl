-module(client).
-export([start/0]).

start()->
	group_leader(whereis(user),self()),
	Server=server:start(server@dreadz,server),
	MM1=mm:start(mm1@dreadz,mm1),
	MM2=mm:start(mm2@dreadz,mm2),
	io:format("[Client]>MM1: ~p, MM2: ~p, Server: ~p~n",[MM1,MM2,Server]),
	MM1!{self(),Server,{newstring,"hello"}},
	MM2!{self(),Server,{newstring,"hello"}}.
