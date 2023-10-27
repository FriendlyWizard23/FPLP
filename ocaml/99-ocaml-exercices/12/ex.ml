type 'a rle =
    | One of 'a
    | Many of int * 'a;;

let decompose element list = 
	match (element) with
	| Many(count,value) -> 
		let rec decompose counter list =
			if counter = count then list
			else decompose (counter+1) (value::list)
		in decompose 0 list
	| One(value) -> (value::list)


let decode list =
	let rec decode newlist = function
	| [] -> List.rev newlist
	| h::tl -> decode (decompose h newlist) tl
	in decode [] list


let print_rle_list list =
	let rec print_rle_list = function
    	| [] -> ()
    	| One x :: tl -> Printf.printf "One %d\n" x; print_rle_list tl
    	| Many (count, value) :: tl -> Printf.printf "Many (%d, %d)\n" count value; print_rle_list tl
  	in print_rle_list list

let () =
  	let test_list = [One 1; Many (3, 2); Many (2, 3); One 4] in
  	print_rle_list test_list;
  	let decoded_list = decode test_list in
  	Printf.printf "Decoded List: [%s]\n" (String.concat "; " (List.map string_of_int decoded_list))
