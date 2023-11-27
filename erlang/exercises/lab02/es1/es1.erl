-module(es1).
-export([squared_int/1, intersect/2, symmetric/2]).

squared_int(List) ->
	[X*X||X<-List,is_integer(X)].
intersect(List1,List2) ->
	[X||X<-List1,lists:member(X,List2)].
symmetric(List1,List2) ->
        [X||X<-List1,not lists:member(X,List2)]++[X||X<-List2,not lists:member(X,List1)].
