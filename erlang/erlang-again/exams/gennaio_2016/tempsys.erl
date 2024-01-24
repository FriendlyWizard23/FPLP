-module(tempsys).
-export([startsys/0,setupNode/3]).

startsys()->
    setupNode('C',fun(C)->C end,fun(C)->C end),
    setupNode('F',fun(F)->0.55*(F-32) end, fun(C)->1.8*C+32 end),
    setupNode('K',fun(K)->K-273.15 end, fun(C)->C+273.15 end),
    setupNode('R',fun(R)->(R-273.15)/1.8 end, fun(C)->(C+273.15)*1.8 end),
    setupNode('De',fun(De)->(De+100)/1.5 end, fun(C)->(100-C)*1.5 end),
    setupNode('N',fun(N)->(N*3.03) end, fun(C)->C*0.33 end),
    setupNode('Re',fun(Re)->(Re/0.8)end, fun(C)->C*(4/5)end),
    setupNode('Ro',fun(Ro)->(Ro*1.9048) end, fun(C)->C*(21/40)+7.5 end),
    ok.
setupNode(Name,ToCelsius,FromCelsius)->
    R=spawn(fun()->temploop(Name,ToCelsius,FromCelsius)end),
    register(Name,R).

temploop(Name,ToCelsius,FromCelsius)->
    receive
    {From,redirect,To,Temp}->
        To!{convert,From,ToCelsius(Temp)},
        temploop(Name,ToCelsius,FromCelsius);
    {convert,From,Temp}->
        From!{FromCelsius(Temp)},
        temploop(Name,ToCelsius,FromCelsius);

    Any -> io:format("~p received ~p~n",[Name,Any])
    end.



