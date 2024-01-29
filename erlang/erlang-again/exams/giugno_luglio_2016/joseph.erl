-module(joseph).
-export([joseph/2]).

joseph(Cookies,Execute)->
    io:format("In a circle of ~p cookies, killing number ~p~n",[Cookies,Execute]),
    hebrew:start(self(),Cookies,Execute),
    receive
    {Last}->io:format("Joseph is the cookie in position ~p~n~n",[Last])
    end.
    