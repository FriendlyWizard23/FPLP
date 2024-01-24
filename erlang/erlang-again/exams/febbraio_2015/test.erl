-module(test).
-export([start/2, bootstrap/0]).

start(_, Functions) ->
    First = spawn(fun() -> start_new(1, Functions) end),
    register(ring, First).

start_new(CurNumber, [Mine | Others]) ->
    io:format("[MEMBER ~p]> Started service ~p. First is ~p~n", [CurNumber, self(), hd(Others)]),
    service_loop(CurNumber, Mine, Others, self()).

service_loop(MyNum, Fun, [Next | Rest], First) ->
    receive
        Any ->
            io:format("[Member]> ~p Received ~p~n", [self(), Any]),
            Next ! Any,
            service_loop(MyNum, Fun, Rest ++ [Next], First)
    end.

bootstrap() ->
    L1 = [fun(X) -> X * N end || N <- lists:seq(1, 7)],
    test:start(7, L1).
