
let last_element list = 
	let rec last_element = function
	| [el] -> el
	| h::tl -> last_element tl
	| [] -> raise(Failure "Empty list" )
	in last_element list
 
let () =
	let list = [1;2;3;4;5;6] in
	let el = last_element list in
	print_int el ;;

