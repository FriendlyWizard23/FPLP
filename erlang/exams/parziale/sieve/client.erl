-module(client).
-export([is_prime/1, quit/0]).
is_prime(N) ->
	
	Reply=net_adm:ping(server@dreadz),
	timer:sleep(500),
	case Reply of
	pang-> 
		io:format("Server not started!~n"),
		exit(kill);
	pong->
		Server=global:whereis_name(server),
		Server!{self(),new,N},
		receive
		{result,R} -> io:format("Is ~p prime? ~p~n",[N,R])
		end	
	end.

quit() ->
	Reply=net_adm:ping(server@dreadz),
	timer:sleep(500),
	case Reply of
	pang-> 
		io:format("Server not started!~n"),
		exit(kill);
	pong->
		Server=global:whereis_name(server),
		Server!{kill},
		io:format("Service is shutting down~n"),
		exit(kill)
	end.
	
