-module(exe1).
-export([lastelement/1]).

lastelement([El])->El;
lastelement([El|Rest])->lastelement(Rest).

