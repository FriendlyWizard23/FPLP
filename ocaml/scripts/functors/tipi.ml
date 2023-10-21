type card = Card of regular | Joker
	and regular = { suit : card_suit; name : card_name; }
  	and card_suit = Heart | Club | Spade | Diamond
  	and card_name = Ace | King | Queen | Jack | Simple of int;;


let value = function
	Joker -> 0
  	| Card {name = Ace} -> 11
  	| Card {name = King} -> 10
  	| Card {name = Queen} -> 9
  	| Card {name = Jack} -> 8
  	| Card {name = Simple n} -> n ;;


let jack:card = Card {suit = Heart; name = Jack} ;;
let cardTest:card = Joker ;;
let jokerVal = value cardTest ;;
let jackVal = value jack ;;
print_int jokerVal ;;
print_string "\n" ;;
print_int jackVal ;;
print_string "\n" ;;
