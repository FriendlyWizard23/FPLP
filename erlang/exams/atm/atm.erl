-module(atm).
-export([start/1, atm_init/1, deposit/3, withdraw/3, balance/2]).

start(N)-> 
	spawn(fun()->atm_init(N)end).

atm_init(N) ->
	AtmName="ATM"++integer_to_list(N),
	global:register_name(AtmName,self()),
	atm_loop(N,AtmName,0).

atm_loop(N,ATMName,Counter) ->
	receive
	{_From,N,Dispatcher,deposit,{Amount}} -> 
		global:whereis_name(Dispatcher)!{self(),{discover,N}},
		receive
			{SubDispatcher}->SubDispatcher!{self(),deposit,{ATMName,Counter,Amount}},atm_loop(N,ATMName,Counter+1);
			Any -> io:format("Received ~p ~n",[Any]),atm_loop(N,ATMName,Counter)
		end;
	{_From,N,Dispatcher,withdraw,{Amount}} -> 
		global:whereis_name(Dispatcher)!{self(),{discover,N}},
		receive
			{SubDispatcher}->SubDispatcher!{self(),withdraw,{ATMName,Counter,Amount}},atm_loop(N,ATMName,Counter+1);
			Any -> io:format("Received ~p ~n",[Any]),atm_loop(N,ATMName,Counter)
		end;
	
	{From,N,Dispatcher,balance} -> 
		global:whereis_name(Dispatcher)!{self(),{discover,N}},
		receive
			{SubDispatcher}->
				SubDispatcher!{self(),balance,{ATMName,Counter}},
				receive
				{Balance} -> From!{Balance}				
				end,
				atm_loop(N,ATMName,Counter+1);		
			_Any -> atm_loop(N,ATMName,Counter)
		end

	end.

deposit(Dispatcher,AtmNumber,Amount) ->
	AtmName="ATM"++integer_to_list(AtmNumber),
	global:whereis_name(AtmName)!{self(),AtmNumber,Dispatcher,deposit,{Amount}}.

withdraw(Dispatcher,AtmNumber,Amount) ->
	AtmName="ATM"++integer_to_list(AtmNumber),
	global:whereis_name(AtmName)!{self(),AtmNumber,Dispatcher,withdraw,{Amount}}.

balance(Dispatcher,AtmNumber) ->
	AtmName="ATM"++integer_to_list(AtmNumber),
	global:whereis_name(AtmName)!{self(),AtmNumber,Dispatcher,balance},
	receive
	{Balance} -> io:format("Balance is: ~p~n",[Balance])
	end.
