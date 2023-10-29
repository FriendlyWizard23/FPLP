let find_nth list k= 
	let rec find_nth counter = function
	| [] -> raise ( Failure "k is too big")
	| h::tl when counter = k -> h
	| h::tl when counter<k -> find_nth (counter+1) tl
	| _ -> raise (Failure "An error occurred")
	in find_nth 0 list;; 

let () =
	let el = find_nth [1;2;3;4;5;6;7;8;9;] 4 in
	print_int el ;; 
