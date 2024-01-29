-module(dispatcher).
-export([start/0]).

start(StartAt)->
    D=spawn(StartAt,fun()->dispatcher_loop()end),
    register(dispatcher,D).

dispatcher_loop()
    receive
    {AtmName,{Action,Seq}}->
        F=whereis(AtmName),
        case F of
            undefined -> spawn(fun()->MMloop(AtmName,0))!{Action,Seq};
            P -> P!{Action,Seq}
        end
    end.

MMloop(MMname,Seq)->
    receive
    Msg -> io:format("~p received ~p~n",[MMname,Msg])
    end.
