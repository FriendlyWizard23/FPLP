let countelements list =
	let rec count counter = function
		| [] -> counter
		| h::tl -> count (counter+1) tl
	in count 0 list

let() =
	let el = countelements [1;2;3;4;5;6;] in
	print_int el ;;
