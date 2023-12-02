-module(joseph).
-export([joseph/2]).

joseph(Jews,HimmlerSays)->
	SixMillionCookies=hebrew:start(Jews),
	SixMillionCookies!{self(),{HimmlerSays,HimmlerSays}},
	ok.
