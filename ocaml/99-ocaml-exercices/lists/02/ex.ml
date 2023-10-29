let find_lbo list =
	let rec find_lbo = function
	| [e1;e2] -> (e1,e2)
	| h::tl -> find_lbo tl
	| _ -> raise (Failure "List Error" ) 
	in find_lbo list ;;

let()=
	let (n1,n2) = find_lbo [1;2;3;4;5;6] in
	print_int n1 ;
	print_int n2 ;; 
