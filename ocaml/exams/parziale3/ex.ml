let sumelements list =
	let rec sumelements prec newlist counter = function
	| [] -> List.rev (counter::newlist) 
	| h::tl when h=prec -> sumelements h newlist (counter+1) tl
	| h::tl -> sumelements h (counter::newlist) 1 tl
	in match list with
	| [] -> raise(Failure "Empty list")
	| [el] -> [1]
	| h::tl -> sumelements h [] 0 list
