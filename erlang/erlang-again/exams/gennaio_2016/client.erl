-module(client).
-export([convert/5]).

convert(from,Scale1,to,Scale2,Temp)->
    Scale1!{self(),redirect,Scale2,Temp},
    receive
    {T}->io:format("~p *~p are equivalent to ~p*~p~n",[Temp,Scale1,T,Scale2])
    end.