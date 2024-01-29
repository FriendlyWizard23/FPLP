-module(atm).
-export([start/1,deposit/3, withdraw/3, balance/2]).

start(N)->
    spawn(fun()->setup(N)end).

setup(N)->
    AtmName=list_to_atom("ATM"++integer_to_list(N)),
    register(AtmName,self()),
    loop(N,AtmName,0).


loop(MyNum,AtmName,Curr)->
    receive
        {balance,Balance}->
            io:format("Balance: ~p~n",[Balance]),
            loop(MyNum,AtmName,Curr);

        {Dispatcher,{AtmName,balance}}->
            net_adm:ping(Dispatcher),
            timer:sleep(500),
            global:whereis_name(Dispatcher)!{MyNum,{self(),AtmName,balance},Curr},
            loop(MyNum,AtmName,Curr+1); 

        {Dispatcher,Msg}->
            io:format("ATM received ~p~n",[Msg]),
            net_adm:ping(Dispatcher),
            timer:sleep(500),
            global:whereis_name(Dispatcher)!{MyNum,Msg,Curr},
            loop(MyNum,AtmName,Curr+1)
    end.

deposit(DispatcherAt,MMNumber,Amount)->
    AtmName=list_to_atom("ATM"++integer_to_list(MMNumber)),
    whereis(AtmName)!{DispatcherAt,{AtmName,deposit,Amount}}.

withdraw(DispatcherAt,MMNumber,Amount)->
    AtmName=list_to_atom("ATM"++integer_to_list(MMNumber)),
    whereis(AtmName)!{DispatcherAt,{AtmName,withdraw,Amount}}.

balance(DispatcherAt,MMNumber)->
    AtmName=list_to_atom("ATM"++integer_to_list(MMNumber)),
    whereis(AtmName)!{DispatcherAt,{AtmName,balance}}.