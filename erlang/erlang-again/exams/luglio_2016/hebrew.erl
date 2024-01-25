-module(hebrew).
-export([start/3]).

start(From,Cookies,Rate)->
    F=spawn(fun()->setup_cookie(From,1,Cookies,self(),self())end),
    F!{pass,Rate,Rate}.

setup_cookie(From,Total,Total,Prec,First)->
    First!{update_prec,self()},
    cookie_loop(From,Total,self(),First,Prec);

setup_cookie(From,CookieN,Total,Prec,First)->
    Iam=self(),
    Next=spawn(fun()->setup_cookie(From,CookieN+1,Total,Iam,First)end),
    cookie_loop(From,CookieN,self(),Next,Prec).

cookie_loop(From,CookieN,Next,Next,Next)->
    From!{CookieN};

cookie_loop(From,CookieN,Self,Next,Prec)->
    receive
    {pass,1,N}->
        Prec!{update_next,Next},
        Next!{update_prec,Prec},
        Next!{pass,N,N};
    {pass,Curr,N}->
        Next!{pass,Curr-1,N},
        cookie_loop(From,CookieN,Self,Next,Prec);
    {update_next,Update}->cookie_loop(From,CookieN,Self,Update,Prec);
    {update_prec,Update}->cookie_loop(From,CookieN,Self,Next,Update);
    Any-> 
        io:format("Received ~p~n",[Any]),
        cookie_loop(From,CookieN,Self,Next,Prec)
    end.
