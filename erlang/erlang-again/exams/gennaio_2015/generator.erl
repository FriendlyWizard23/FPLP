-module(generator).
-export([start/2,increasePrint/2]).

start(Columns,Numbers)->setup(Columns,Numbers).

setup(0,_)->[];
setup(MyColumn,Numbers)->[spawn(fun()->loop(MyColumn-1,0,1,(round(math:pow(Numbers,MyColumn-1))),1,Numbers)end)|setup(MyColumn-1,Numbers)].

increasePrint(N,Numbers)->
    case ((N+1) rem Numbers) of 
    0 -> Numbers;
    S -> S
    end.

loop(MyColumn,SeqMSG,InternalCounter,SelfMax,Print,Numbers) when InternalCounter>=SelfMax->
    %io:format("I AM COLUMN ~p WITH SELF MAX ~p ~n",[MyColumn,SelfMax]),
    receive
        {From,quit} ->
            From!{ok};
        {From,SeqMSG}->
            %io:format(">>~p~n",[Print]),
            From!{MyColumn,Print},
            loop(MyColumn,SeqMSG+1,1,SelfMax,increasePrint(Print,Numbers),Numbers)
    end;

loop(MyColumn,SeqMSG,InternalCounter,SelfMax,Print,Numbers)->
    %io:format("I AM COLUMN ~p WITH SELF MAX ~p ~n",[MyColumn,SelfMax]),
    receive
        {From,quit} ->
            From!{ok};
        {From,SeqMSG}-> 
            %io:format(">>~p~n",[Print]),
            From!{MyColumn,Print},
            loop(MyColumn,SeqMSG+1,InternalCounter+1,SelfMax,Print,Numbers)

    end.
