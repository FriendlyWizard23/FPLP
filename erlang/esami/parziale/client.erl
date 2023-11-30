-module(client).
-export([start/0, test/0, stop/0]).

start()->
	global:register_name(client,self()),
	mm:start('mm1@dreadz',mm1),
	mm:start('mm2@dreadz',mm2),
	server:start('server@dreadz').

test()->
	global:whereis_name(mm1)!{self(),{[1,2,3,4]}},
	global:whereis_name(mm2)!{self(),{[5,6,7,8]}},
	receive
	{Reply} -> io:format("Reply: ~p",[Reply]);
	{'EXIT',Pid,Why} -> io:format("Dying now...\n"), exit(normal)
	end.

stop() ->
	exit(stopped).
