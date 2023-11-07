-module (spawner).
-export([start/0]).

start()->
	Pid=spawn(area,area,[]),
	Pid ! {self(),{rectangle,10,20}},
	receive
		{Pid, Reply} -> Reply
	end.
