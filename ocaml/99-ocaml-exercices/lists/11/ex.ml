type 'a rle =
    | One of 'a
    | Many of int * 'a;;

let tuples list =
	let rec tuples currcount newlist last = function
	| [] when currcount>0 -> List.rev ((Many(currcount,last)) :: newlist)
	| [] when currcount=0 -> List.rev newlist
	| h::tl when h=last ->	tuples (currcount+1) newlist h tl
	| h::tl when h<>last -> 
		if currcount=1 then 
			tuples 1 ((One(last))::newlist) h tl 
		else  
			tuples 1 ((Many(currcount,last))::newlist) h tl
	| _ -> raise(Failure "Error")
	in tuples 0 [] (List.hd list) list

let print_rle_list list =
  let rec print_rle_list = function
    | [] -> ()
    | One x :: tl ->
      Printf.printf "One %d\n" x;
      print_rle_list tl
    | Many (n, x) :: tl ->
      Printf.printf "Many (%d, %d)\n" n x;
      print_rle_list tl
  in
  print_rle_list list

let () =
  let test_list = tuples[1;1;2;2;2;3;4;4;] in
  print_rle_list test_list
