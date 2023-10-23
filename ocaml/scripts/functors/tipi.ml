type card = Card of regular | Joker
	and regular = { suit : card_suit; name : card_name; }
  	and card_suit = Heart | Club | Spade | Diamond
  	and card_name = Ace | King | Queen | Jack | Simple of int;;

let suits = [Heart;Club;Spade;Diamond] ;;
let names = [Ace;King;Queen;Jack;Simple 10; Simple 9; Simple 8; Simple 7; Simple 6; Simple 5; Simple 4; Simple 3; Simple 2; Simple 1] ;;

let generateDeck suits names =

let value = function
	Joker -> 0
  	| Card {name = Ace} -> 11
  	| Card {name = King} -> 10
  	| Card {name = Queen} -> 9
  	| Card {name = Jack} -> 8
  	| Card {name = Simple n} -> n ;;


let jack:card = Card {suit = Heart; name = Jack} ;;
let cardTest:card = Joker ;;
let list=[jack;cardTest;] ;;
