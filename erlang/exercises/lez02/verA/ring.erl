-module(ring).
-export([start/3]).


spawnN(0) -> [];
spawnN(N) -> [mainproc:start()|spawnN(N-1)].

start(N,M,Message) -> 
	PS=spawnN(N),
	sendmessages(PS,M,Message),
	sendmessages(PS,1,terminate).	
	
sendmessages([],_) -> [];
sendmessages([El|Rest],Message) -> [mainproc:rpc(El,Message)|sendmessages(Rest,Message)].

sendmessages(L,0,Message) -> ok;
sendmessages(L,M,Message) -> 
	io:format("~s~n", [io_lib:format(" ===================== BULK NO ~p ===================== ", [M])]),
	sendmessages(L,Message),
	timer:sleep(1000),
	sendmessages(L,M-1,Message).

	

