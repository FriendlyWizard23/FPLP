-module(generator).
-export([start/2,increaseOnModulus/2]).

start(0,_)->[];
start(Columns,Numbers)->[spawn(fun()->setup(Columns,round(math:pow(Numbers,(Columns-1))),1,Numbers)end)|start(Columns-1,Numbers)].

setup(Column,MaxCounter,LocalCounter,Numbers)->
    io:format("Started Column ~p with MC ~p and LC ~p~n",[Column,MaxCounter,LocalCounter]),
    loop(Column,MaxCounter,LocalCounter,1,Numbers).

increaseOnModulus(N,Modulus)->
    case (N+1)rem Modulus of
    0 -> Modulus;
    V -> V
    end.

loop(Column,MaxCounter,MaxCounter,ToPrint,Numbers)->
    receive
    {From,increase} -> 
        From!{ToPrint},
        loop(Column,MaxCounter,1,increaseOnModulus(ToPrint,Numbers),Numbers)
    end;

loop(Column,MaxCounter,LocalCounter,ToPrint,Numbers)->
    receive
    {From,increase} -> 
        From!{ToPrint},
        loop(Column,MaxCounter,LocalCounter+1,ToPrint,Numbers)
    end.


