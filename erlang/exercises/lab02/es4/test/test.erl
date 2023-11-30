-module(test).
-export([testme/1]).

testme(String) -> send_partitioner([1,2,3,4,5,6,7,8,9,10],String,string:len(String) div 10).

send_partitioner([],_,_)->[];
send_partitioner([El],String,Size) -> [String];
send_partitioner([El|Rest],String,Size) ->
        [string:substr(String,1,Size)|send_partitioner(Rest,string:substr(String,Size+1),Size)].
