module type BlackjackDeck = sig
	type card = Card of regular | Joker
   	and regular = { suit : card_suit; name : card_name }
   	and card_suit = Heart | Club | Spade | Diamond
   	and card_name = Ace | King | Queen | Jack | Simple of int

  	val value : card -> int
end

module BJD : BlackjackDeck = struct
	type card = Card of regular | Joker
   	and regular = { suit : card_suit; name : card_name }
   	and card_suit = Heart | Club | Spade | Diamond
   	and card_name = Ace | King | Queen | Jack | Simple of int

  	let value = function
    	| Joker -> 0
    	| Card { name = Ace } -> 11
    	| Card { name = King } -> 10
    	| Card { name = Queen } -> 9
    	| Card { name = Jack } -> 8
    	| Card { name = Simple n } -> n
end

let () =
  	let open BJD in
  	let joker = Joker in
  	let qha = Card { suit = Heart; name = Queen } in
  	let _ = print_int (value joker) in
  	let _ = print_newline () in
  	let _ = print_int (value qha) in
  	print_newline ();
