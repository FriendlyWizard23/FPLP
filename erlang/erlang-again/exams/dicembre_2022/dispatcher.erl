-module(dispatcher).
-export([start/1]).

start(BankAt)->
    net_adm:ping(BankAt),
    timer:sleep(500),
    BankPID=global:whereis_name(bank),
    io:format("BANK PID IS ~p~n",[BankPID]),
    global:register_name(dispatcher@dreadz,spawn(fun()->dispatcher_setup(BankPID)end)).

dispatcher_setup(BankAt)->
    group_leader(whereis(user),self()),
    io:format("Starting dispatcher ~n"),
    dispatcher_loop(BankAt).

dispatcher_loop(BankAt)->
    receive
    {AtmNum,Action,Seq}->
        MMname=list_to_atom("MM"++integer_to_list(AtmNum)),
        case whereis(MMname) of
            undefined -> spawn(fun()->mmsetup(BankAt,MMname,0)end)!{Action,Seq},dispatcher_loop(BankAt);
            P -> P!{Action,Seq},dispatcher_loop(BankAt)
        end
    end.

mmsetup(BankAt,MMname,Seq)->
    register(MMname,self()),
    mmloop(BankAt,MMname,Seq).

mmloop(BankAt,MMname,Seq)->
    receive   
    {{From,ATMName,balance},Seq} -> 
        io:format("i'm ~p and i dealt with MSG #~p~n",[MMname,Seq]),
        BankAt!{From,ATMName,Seq,{balance}},
        mmloop(BankAt,MMname,Seq+1);
    {{ATMName,Action,Amount},Seq} -> 
        io:format("i'm ~p and i dealt with MSG #~p~n",[MMname,Seq]),
        BankAt!{ATMName,Seq,{Action,Amount}},
        mmloop(BankAt,MMname,Seq+1);
    Any -> 
        io:format("Received unknown stuff: ~p~n",[Any]),
        mmloop(BankAt,MMname,Seq+1)
    end.
