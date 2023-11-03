-module(exe2).
-export([lastbutone/1]).

lastbutone([El1,El2|[]])->El1;
lastbutone([_|Rest])->lastbutone(Rest).
