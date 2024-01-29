-module(bank).
-export([start/0,setup/0]).

start()->spawn(fun()->setup()end).
setup()->
    global:register_name(bank,self()),
    group_leader(whereis(user),self()),
    bank_loop(0,5000,0).

bank_loop(Balance,Max,GlobalCounter)->
    receive
        {Who,LocalSeq,{withdraw,Amount}} when Balance-Amount>=0 -> 
            io:format("I got a withdraw of ~p from ~p (Local msg ~p global msg ~p)~n",[Amount,Who,LocalSeq,GlobalCounter]),
            bank_loop(Balance-Amount,Max,GlobalCounter+1);
        {Who,LocalSeq,{withdraw,Amount}}-> 
            io:format("I got a withdraw of ~p from ~p (Local msg ~p global msg ~p)~n",[Amount,Who,LocalSeq,GlobalCounter]),
            bank_loop(Balance,Max,GlobalCounter+1);
        
        {Who,LocalSeq,{deposit,Amount}} when Balance+Amount=<5000 -> 
            io:format("I got a deposit of ~p from ~p (Local msg ~p global msg ~p)~n",[Amount,Who,LocalSeq,GlobalCounter]),
            bank_loop(Balance+Amount,Max,GlobalCounter+1);
        
        {Who,LocalSeq,{deposit,Amount}}-> 
            io:format("I got a deposit of ~p from ~p (Local msg ~p global msg ~p)~n",[Amount,Who,LocalSeq,GlobalCounter]),
            bank_loop(Balance,Max,GlobalCounter+1);
        {From,Who,LocalSeq,{balance}}-> 
            io:format("I got a balance request from ~p (Local msg ~p global msg ~p)~n",[Who,LocalSeq,GlobalCounter]),
            From!{balance,Balance},
            bank_loop(Balance,Max,GlobalCounter+1)
                       
    end.