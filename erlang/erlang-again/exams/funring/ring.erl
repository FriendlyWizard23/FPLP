-module(ring).
-export([start/2,default/0,send_message/1,send_message/2,quit/0]).

start(_,Functions)-> 
    First = spawn(fun()->start_new(1,Functions)end),
    register(ring,First).

start_new(CurNumber,[Mine|Others])->
    Next=spawn(fun()->start_new(CurNumber+1,Others,self())end),
    service_loop(CurNumber,Mine,Next,self()).

start_new(MyNum,[Last],First)->
    service_loop(MyNum,Last,none,First);    

start_new(CurNumber,[Mine|Others],First)->
    Next=spawn(fun()->start_new(CurNumber+1,Others,First)end),
    service_loop(CurNumber,Mine,Next,First).


service_loop(MyNum,Fun,Next,First)->
    receive
        {quit}->
            case Next of
                none -> io:format("[RING]>~p is quitting~n",[MyNum]);
                _ ->io:format("[RING]>~p is quitting~n",[MyNum]), Next!{quit}
            end;
        {one_round,N} -> 
            case Next of
                none -> 
                    io:format("[RING]>I calculated: ~p~n",[Fun(N)]),
                    service_loop(MyNum,Fun,Next,First);
                _ -> 
                    Next!{one_round,Fun(N)},
                    service_loop(MyNum,Fun,Next,First)
            end;
        {n_rounds,N,1}->
            case Next of
                none -> 
                    io:format("[RING]>I calculated: ~p~n",[Fun(N)]),
                    service_loop(MyNum,Fun,Next,First);
                _ -> 
                    Next!{n_rounds,Fun(N),1},
                    service_loop(MyNum,Fun,Next,First)
            end;

        {n_rounds,N,Rounds}->
            case Next of
                none -> 
                    First!{n_rounds,Fun(N),Rounds-1},
                    service_loop(MyNum,Fun,Next,First);
                _ -> 
                    Next!{n_rounds,Fun(N),Rounds},
                    service_loop(MyNum,Fun,Next,First)
            end

     
    end.

default()->
    L1 = [fun(X)->X*N end || N<-lists:seq(1,7)],
    ring:start(7,L1).

send_message(N)->
    whereis(ring)!{one_round,N}.

send_message(N,R)->
    whereis(ring)!{n_rounds,N,R}.

quit()->
    whereis(ring)!{quit}.
