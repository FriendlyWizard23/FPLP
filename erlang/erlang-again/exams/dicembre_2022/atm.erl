-module(atm).
-export([start/1]).

start(N)->
    spawn(fun()->setup(N)end).

setup(N)->
    AtmName="MM"++integer_to_list(N),
    loop(AtmName,0).


loop(AtmName,Curr)->
    receive
        {Curr,Msg}->
            global:whereis_name(dispatcher)!{AtmName,{Msg,Curr}},
            loop(AtmName,Curr+1)
    end.

