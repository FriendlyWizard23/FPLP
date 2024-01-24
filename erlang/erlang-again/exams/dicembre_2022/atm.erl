-module(atm).
-export([start/1,setup/1]).

start(N)->
    spawn(fun()->setup(N)end).

setup(N)->
    AtmName="MM"++integer_to_list(N),
    global:register_name(AtmName,self()),
    io:format("~p STARTED~n",[AtmName]),
    loop(AtmName,0).

sender_rpc(From,Message)->
    From!{self(),{Message}}.

loop(AtmName,Curr)->
    receive
        {Curr,Msg}->
            io:format("I'm ~p and i dealt with MSG # ~p\n",[AtmName,Msg]),
            global:whereis_name(bank)!{self(),Msg},
            loop(AtmName,Curr+1)
    end.

