-module(counter).
-export([start/0, loop/4]).

start() -> 
	Spid=spawn(?MODULE,loop,[0,0,0,0]),
	register(cserver,Spid),
	{server,Spid,ok}.

loop(D1c,D2c,D3c,Totc) ->
	receive
	{From,{stop}} -> From!{stopped,ok},exit(normal);
	{From,{dummy1}} -> From!{dummy1,ok}, loop(D1c+1,D2c,D3c,Totc);
	{From,{dummy2}} -> From!{dummy2,ok}, loop(D1c,D2c+1,D3c,totc);
	{From,{dummy3}} -> From!{dummy3,ok}, loop(D1c,D2c,D3c+1,Totc);
	{From,{tot}} -> From!([{dummy1,D1c},{dummy2,D2c},{dummy3,D3c},{tot,Totc+1}]), loop(D1c,D2c,D3c,Totc+1)
	end.
