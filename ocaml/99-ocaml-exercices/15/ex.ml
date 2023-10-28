let duplicate list n = 
	let rec producelist el n list counter =
		match counter with
		| value when value = n -> list
		| value when value <> n -> producelist el n (el::list)(counter+1)
		| _ -> raise(Failure "Error") in

	let rec duplicate newlist = function
	| [] -> newlist
	| h::tl -> duplicate (producelist h n newlist 0) tl
	in duplicate [] list

let print_list lst =
  	let rec print_elements = function
    	| [] -> ()
    	| hd :: tl ->
     	print_int hd;  (* Cambia 'print_int' con 'print_endline' se vuoi stampare interi su righe separate *)
     	print_string " ";
      	print_elements tl
  	in
  	print_string "[";
  	print_elements lst;
  	print_endline "]"

let () =
  	let sample_list = [1; 2; 3] in
  	let n = 3 in
  	let result = duplicate sample_list n in
  	print_list result

