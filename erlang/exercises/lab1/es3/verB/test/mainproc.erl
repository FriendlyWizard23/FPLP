-module(mainproc).
-export([start/3, loop/0, rpc/2, generator/4]).

start(M, N, Message) ->
	MainPid = spawn(?MODULE, generator, [0, N, M, Message]),
	io:format("Main process: ~p has started~n", [MainPid]),
	sendMessages(M, Message, MainPid),
	sendMessages(M,terminate,MainPid).

rpc(Pid, Message) ->
	Pid ! {Message}.

generator(Counter, N, M, Message) when Counter < N ->
	NextPid = spawn(?MODULE, generator, [Counter + 1, N, M, Message]),
	io:format("PROCESS: ~p HAS SPAWNED PROCESS ~p ~n",[self(),NextPid]),
	io:format("PROCESS: ~p IS NOW LISTENING~n", [self()]),	
	loop(NextPid, M, Message);

generator(Counter, N, _M, _Message) when Counter >= N ->
	io:format("PROCESS: ~p IS NOW LISTENING~n", [self()]),
	io:format("~s~n", [" ===================== SETUP COMPLETE  ===================== "]),
	loop().

loop() ->
	receive
        {terminate} ->
		io:format("LAST PROCESS is number: ~p and has been terminated~n", [self()]),
		exit(normal);
        {Message} ->
		io:format("LAST PROCESS is number: ~p and says: ~p~n\n", [self(), Message]),
		timer:sleep(500),
		loop()
    end.

loop(NextPid, M, Message) ->
	receive
	{terminate} ->
		io:format("Process number: ~p has been terminated~n", [self()]),
		rpc(NextPid,Message),
		exit(normal);
	{Message} ->	
		io:format("Process number: ~p says: ~p~n\n", [self(), Message]),	
		rpc(NextPid,Message),
		loop(NextPid, M, Message)
    end.

sendMessages(0, _Message, _Pid) -> eot;
sendMessages(M, Message, Pid) ->
	rpc(Pid, Message),
	timer:sleep(2000),
	sendMessages(M - 1, Message, Pid).
