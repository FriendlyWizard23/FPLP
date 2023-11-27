-module(test1).
-export([start/0, loop/0]).

start() ->
    io:format("GENERATING 3 PROCESSES...\n"),
    Pids = spawn_processes(3),
    io:format("Generated processes: ~p\n", [Pids]),
    Pids.
spawn_processes(0) -> [];
spawn_processes(N) ->
    [spawn(fun() -> loop() end) | spawn_processes(N - 1)].

loop() ->
    io:format("LOOP PROCESS ~p STARTED\n", [self()]),
    receive
        {From, Msg} ->
            io:format("Received message ~p from ~p\n", [Msg, From]),
            From ! Msg,
            loop();
        stop ->
            io:format("LOOP PROCESS ~p STOPPED\n", [self()])
    end.
