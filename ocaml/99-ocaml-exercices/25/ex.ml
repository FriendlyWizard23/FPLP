let permutation list = 
	let () = Random.self_init () in
	let rec remove_pos pos newlist = function
	| [] -> newlist
	| h::tl when pos <> 0 -> remove_pos (pos-1)(h::newlist)tl
	| h::tl -> remove_pos (pos-1)(newlist)tl
	in
	let rec permutation newlist list size=
	match size with
	| size when size>0 -> let ran=Random.int(List.length list) in permutation ((List.nth list ran)::newlist) (remove_pos ran [] list)(size-1)
	| size -> List.rev newlist
	in permutation [] list (List.length list)

let () =
  let myList = [1; 2; 3; 4; 5;6;7;8;9;10;11;12] in
  let shuffledList = permutation myList in
  Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
  Printf.printf "Shuffled List: [%s]\n" (String.concat "; " (List.map string_of_int shuffledList))
