-module(receiver).
-export([start/1]).

start(SpawnAt)->
    Receiver=spawn(SpawnAt,fun()->setup()end),
    global:register_name(receiver,Receiver).

setup()->
    group_leader(whereis(user),self()),
    io:format("Listening..~n"),
    receiver_loop(0,"").

receiver_loop(Counter,FinalString)->
    receive
        {quit}->
            io:format("[Receiver]> shutting down...~n");
        {eot,{finished,Counter}}->
            io:format("~n[Receiver]>Finished receiving: ~p~n",[FinalString]),
            receiver_loop(0,"");
        {Slice,Counter}->
            io:format("[Receiver]> recieved ~p with Counter ~p~n",[Slice,Counter]),
            receiver_loop(Counter+1,FinalString++Slice)
    end.
