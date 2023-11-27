-module(blackjack).
-export([start/2,start_default/0, server/0, deal_card/0]).

start_default() -> start('server@dreadz',3).
start(Node,Decks) ->
	Spawned=spawn(Node,fun()->server() end),
	put(game_deck, (deck:shuffle_deck(deck:generate_decks(Decks)))),
	put(status,closed),
	register(bjserver,Spawned),
	ok.
	
server() -> 
	receive
	{From,{connect}} -> 
		put(status,connected), 
		From!{ready_to_play};
	
	{From,{hit}} -> 
		case get(status) of
		closed -> From!{conn_err};
		_ -> From!{deal_card()}
		end
	end.

update_deck(Deck)-> put(game_deck,Deck).
deal_card([El|Rest]) -> 
	update_deck(Rest),
	El.

deal_card() -> 
	deal_card(get(game_deck)).
