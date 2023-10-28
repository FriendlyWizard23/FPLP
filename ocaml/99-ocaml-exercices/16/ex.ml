let drop list n = 
	let rec drop counter newlist= function
	| [] -> List.rev newlist
	| h::tl when ((counter mod n ) <> 0 ) -> drop (counter+1)(h::newlist) tl
	| h::tl -> drop (counter+1)(newlist) tl	
	in 
	match n with
	| n when n > (List.length list) -> raise(Failure "n value too big!")
	| _ -> drop 1 [] list
;;

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
  let n = 3 in
  let result = drop sample_list n in
  print_list result
