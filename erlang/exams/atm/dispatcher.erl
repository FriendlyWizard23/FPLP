-module(dispatcher).
-export([start/1]).

start(BankNode) -> 
	Master=spawn('dispatcher@dreadz',fun()->init_master(BankNode)end),
	global:register_name(dispatcher@dreadz,Master).

init_master(BankNode)->
	group_leader(whereis(user),self()),
	io:format("Dispatcher Spawned!~n"),
	process_flag(trap_exit,true),
	master(BankNode,[]).

findPID([],_)->undefined;
findPID([{Num,Pid}|_Rest],Num)->Pid;
findPID([{_N,_Pid}|Rest],Num)->findPID(Rest,Num).
	
master(BankNode,Dispatchers) ->	
	receive
		{_From,{new,N}} -> 
			Generated=init_slave(BankNode,N),
			master(BankNode,[{N,Generated}|Dispatchers]);
		{From,{discover,N}} ->
			Found=findPID(Dispatchers,N),
			case Found of
			undefined -> 
				Generated=init_slave(BankNode,N),
				From!{Generated},
				master(BankNode,[{N,Generated}|Dispatchers]);
			Pid -> From!{Pid},master(BankNode,Dispatchers)
			end			
	end.

init_slave(BankNode,N)->
	Curname=list_to_atom("MM"++integer_to_list(N)),
	DispatcherSlave=spawn(fun()->loop(BankNode,N,Curname,0)end),
	DispatcherSlave.

loop(BankNode,N,Name,Counter)->
	receive
	{_From,deposit,{ATMName,Counter,Amount}} ->
		io:format("i am ~p and i dealt with MSG #~p~n",[Name,Counter]),
		global:whereis_name(BankNode)!{self(),deposit,{ATMName,Counter,Amount}},
		loop(BankNode,N,Name,Counter+1);

	{From,balance,{ATMName,Counter}} ->
		io:format("i am ~p and i dealt with MSG #~p~n",[Name,Counter]),
		global:whereis_name(BankNode)!{self(),balance,{ATMName,Counter}},
		receive
		{Balance}->From!{Balance}
		end,
		loop(BankNode,N,Name,Counter+1);

	{_From,withdraw,{ATMName,Counter,Amount}} ->
		io:format("i am ~p and i dealt with MSG #~p~n",[Name,Counter]),
		global:whereis_name(BankNode)!{self(),withdraw,{ATMName,Counter,Amount}},
		loop(BankNode,N,Name,Counter+1);
	_-> loop(BankNode,N,Name,Counter)
	end.
	
