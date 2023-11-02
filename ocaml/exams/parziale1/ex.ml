let sumvalues list = 
	let rec sumvalues newlist prev summer = function
	| [] -> List.rev newlist
	| h::tl when (h=0)&&(prev=0) -> sumvalues newlist h 0 tl
	| h::tl when (h<>0) -> sumvalues newlist h (summer+h) tl
	| h::tl -> sumvalues (summer::newlist) h 0 tl
	in sumvalues [] (List.hd list) 0 list

let rec print_list lst =
  match lst with
  | [] -> ()
  | h::t ->
    Printf.printf "%d " h;
    print_list t

let () = 
	print_list (sumvalues [1; 2; 3; 0; 4; 5; 0; 0; 6; 6])
	
