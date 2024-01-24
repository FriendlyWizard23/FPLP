-module(combinator).
-export([start/2]).

start(Columns,Numbers)->
    G=generator:start(Columns,Numbers),
    io:format("Combinator generated: ~p~n",[G]),
    loopAll(0,(round(math:pow(Numbers,Columns))),G).
    
loopAll(To,To,_)->ok;
loopAll(From,To,Generated)->
    loopColumns(From,Generated),
    loopAll(From+1,To,Generated).

loopColumns(_,[])->
    io:format("~n"),
    timer:sleep(500);
loopColumns(Number,[El|Rest])->
    sendBroadcast(El,Number),
    loopColumns(Number,Rest).

sendBroadcast(Pid,Seq)->
    Pid!{self(),Seq},
    receive 
    {_,Reply}->io:format("~p ",[Reply])
    end.

