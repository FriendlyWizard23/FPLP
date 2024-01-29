-module(combinator).
-export([start/2]).

start(Columns,Numbers)->
    G=generator:start(Columns,Numbers),
    Max=round(math:pow(Numbers,Columns)),
    loopToMax(G,Max).

loopToMax(_,0)->ok;
loopToMax(G,Max)->
    sendAll(G),
    loopToMax(G,Max-1).

sendAll([])->io:format("~n");
sendAll([G1|Rest])->
    G1!{self(),increase},
    receive
    {ToPrint}->io:format("~p ",[ToPrint])
    end,
    sendAll(Rest).