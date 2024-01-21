-module(switch).
-export([start/1,switchloop/1]).

start(Nswitches)->
    setup(Nswitches,1).

setup(0,_)->[];
setup(Nswitches,Curr)->[spawn(fun()->switchloop(Curr)end)|setup(Nswitches-1,Curr+1)].

switchloop(N)->
    receive
    {eot,{finished,Counter}}->
       global:whereis_name(receiver)!{eot,{finished,Counter}},
       io:format("The switch #~p is finishing the sequence~n",[N]),
       switchloop(N);
    {Slice,Counter}->
        global:whereis_name(receiver)!{Slice,Counter},
        io:format("The switch #~p is routing the message ~p with counter ~p~n",[N,Slice,Counter]),
        switchloop(N);
    {quit}->
        io:format("The switch #~p is gracely exiting~n",[N])
    end.
