module type BlackjackDeck = sig
	type card
	val value: card -> int 
	
end
