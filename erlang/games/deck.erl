-module (deck).
-export([generate_decks/1, shuffle_deck/1]).

combine([],_)->[];
combine([El|Rest],Seed) ->[(cards:new_card(El,Seed))|combine(Rest,Seed)].	 

generate_deck(_,[])->[];
generate_deck(Values,[El|Rest]) ->combine(Values,El)++generate_deck(Values,Rest).
generate_deck() -> generate_deck([1,2,3,4,5,6,7,8,9,10,jack,queen,king,ace],[hearts,spades,clubs,diamonds]).

generate_decks(N) when N>0 -> generate_deck()++generate_decks(N-1);
generate_decks(N) -> [].

shuffle_deck(Deck) when is_list(Deck)->shuffle:shuffle(Deck);
shuffle_deck(Deck) -> bad_arg.
