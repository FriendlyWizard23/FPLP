let duplicate list = 
	let rec duplicate newlist = function
	| [] -> List.rev newlist
	| h::tl -> duplicate (h::h::newlist) tl
	in duplicate [] list

let print_list lst =
	let rec print_elements = function
    	| [] -> ()
    	| h::t ->
      		print_int h;
     		print_string " ";
      		print_elements t
  	in
  		print_elements lst;
  		print_newline ()

let () =
  	let original_list = [1; 2; 3; 4; 5; 5; 5] in
  	let duplicated_list = duplicate original_list in
  	print_string "Original List: ";
  	print_list original_list;
  	print_string "Duplicated List: ";
  	print_list duplicated_list
