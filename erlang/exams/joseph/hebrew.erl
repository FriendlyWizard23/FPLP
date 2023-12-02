-module(hebrew).
-export([start/1]).

start(Hebrews)->start(0,Hebrews,self()).

start(SeqNumber,SeqNumber,First) -> First;

start(1,Hebrews,_First) -> 
	process_flag(trap_exit,true),
	SelfPid=self(),
	spawn_link(fun() -> init(SelfPid,1,Hebrews,SelfPid) end);

start(SeqNumber,Hebrews,First)-> 
	process_flag(trap_exit,true),
	SelfPid=self(),
	spawn_link(fun() -> init(SelfPid,SeqNumber,Hebrews,First) end).

init(FatherPID,Seq,Hebrews,First) when (Seq)==(Hebrews-1)->
	Son=start(Seq+1,Hebrews,First),
	First!{self(),update_father,self()},
	loop(Hebrews,0,FatherPID,Seq,self(),Son);

init(FatherPID,Seq,Hebrews,First)->
	Son=start(Seq+1,Hebrews,First),
	loop(Hebrews,0,FatherPID,Seq,self(),Son).

loop(Hebrews,Execution,SelfPid,Seq,SelfPid,SelfPid) -> 
	io:format("In a circle of ~p cookies, killing number ~p. ~nJoseph is the Cookie in position ~p~n",[Hebrews,Execution,Seq+1]);

loop(Hebrews,Execution,FatherPID,Seq,_SelfPid,SonPID) ->
	receive
		%%UPDATE FATHER AND UPDATE SON
		{_From,update_father,NewFatherPid} ->loop(Hebrews,Execution,NewFatherPid,Seq,self(),SonPID);
		{_From,update_son,NewSonPid}->loop(Hebrews,Execution,FatherPID,Seq,self(),NewSonPid);		

		%% SUICIDE 
		{_From,{Resend,1}} -> 
			FatherPID!{self(),update_son,SonPID},
			SonPID!{self(),update_father,FatherPID},
			SonPID!{self(),{Resend,Resend}};
		
		%% MESSAGE FORWARD
		{From,{Resend,Count}} -> SonPID!{From,{Resend,Count-1}},loop(Hebrews,Resend,FatherPID,Seq,self(),SonPID)
				
	end.
