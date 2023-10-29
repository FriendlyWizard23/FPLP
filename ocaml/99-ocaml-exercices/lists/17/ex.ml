let separate list size = 
	let rec separate counter newlist = function
	| [] -> ((List.rev newlist),[])
	| h::tl when counter <> size -> separate (counter+1) (h::newlist) tl  
	| h::tl -> ((List.rev (h::newlist)),tl)
	in
	match size with
	| value when value>(List.length list) -> raise(Failure "Invalid size" )
	| _ -> separate 0 [] list

let print_list lst =
	let rec print_elements = function
    	| [] -> ()
    	| hd :: tl ->
      	print_int hd;
      	print_string " ";
      	print_elements tl
  	in
  	print_string "[";
  	print_elements lst;
  	print_endline "]"

let () =
  	let sample_list = [1; 2; 3; 4; 5; 6; 7; 8; 9] in
  	let size = 4 in
  	let (first_part, second_part) = separate sample_list size in
  	print_endline "First Part:";
  	print_list first_part;
 	print_endline "Second Part:";
  	print_list second_part
