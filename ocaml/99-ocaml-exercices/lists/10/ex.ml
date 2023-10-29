let tuples list =
	let rec tuples currcount newlist last = function
	| [] when currcount>0 -> List.rev ((last, currcount) :: newlist)
	| [] when currcount=0 -> List.rev newlist
	| h::tl when h=last ->	tuples (currcount+1) newlist h tl
	| h::tl when h<>last -> tuples 1 ((last,currcount)::newlist) h tl
	| _ -> raise(Failure "Error")
	in tuples 0 [] (List.hd list) list

let print_list list =
	let rec print_list = function
		| [] -> ()
		| (x,y)::tl -> (Printf.printf "%d %d\n" x y); print_list tl
	in print_list list

 let() = 
	let test = tuples[1;1;1;1;2;2;3;3;3;4] in
	print_list test ;;
