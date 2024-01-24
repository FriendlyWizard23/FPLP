-module(sender).
-export([start/2,send_msg/1,quit/0]).

start(Nswitches,Atreceiver)->
    io:format("Starting sender~n"),
    receiver:start(Atreceiver),
    SenderPid=spawn(fun()->sender_loop(switch:start(Nswitches))end),
    register(sender,SenderPid).

sender_loop(Switches)->
    receive
        {quit}->
            quitall(Switches);
        {send_msg,Msg} -> 
            io:format("MSG TO BE SENT: ~p~n",[Msg]),
            partitionate_and_send(Switches,string:tokens(Msg," "),0),
            sender_loop(Switches)
    end.

send_msg(Msg)->
    whereis(sender)!{send_msg,Msg}.

quit()->
    whereis(sender)!{quit}.

quitall([])->[];
quitall([S1|Rest])->
    S1!{quit},
    quitall(Rest).

partitionate_and_send([S1|_],[],Counter)->
    S1!{eot,{finished,Counter}};

partitionate_and_send([S1|RestSwitches],[El|RestMessage],Counter)->
    S1!{El,Counter},
    partitionate_and_send((RestSwitches++[S1]),RestMessage,Counter+1).

    
