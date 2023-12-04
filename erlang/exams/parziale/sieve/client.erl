-module(client).
-export([is_prime/1]).
is_prime(N) ->
	
	net_adm:ping(server@dreadz),
	Server=global:whereis_name(server),
	Server!{self(),new,N},
	receive
	{result,R} -> io:format("Is ~p prime? ~p~n",[N,R])
	end.	
