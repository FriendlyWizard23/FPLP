-module(demo).
-export([start/1, rpc/4, loop/0]).

start(Node) -> spawn(Node,fun()->loop()end).

rpc(Pid,Module,Func,Args) ->
	Pid!{rpc, self(),Module,Func,Args},
	receive
		{Pid,Reply} -> Reply
	end.

loop() ->
	receive
	{rpc,Pid,Module,Func,Args} -> Pid!{self(),(catch apply(Module,Func,Args))},
	loop()
	end.
