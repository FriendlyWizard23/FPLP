let maxs list =
	let rec findmin min = function
	| [] -> min
	| h::tl when h<min -> findmin h tl
	| h::tl -> findmin min tl
	in
	let rec maxs max1 max2 = function
	| [] -> [max1;max2]
	| h::tl when h>=max1 -> maxs h max1 tl
	| h::tl when h>max2-> maxs max1 h tl
	| h::tl -> maxs max1 max2 tl
	in 
	match list with 
	| [el] -> raise(Failure "List has only one element.")
	| h::h2::tl -> maxs (findmin h list) (findmin h list) list
	| [] -> raise(Failure "List is empty")

	
	
