let rotate_left list positions =	
	let rec rotate_left counter newlist to_concat = function
	| [] -> (List.rev newlist)@(List.rev to_concat)
	| h::tl when (counter<positions) -> rotate_left (counter+1)(newlist)(h::to_concat) tl
	| h::tl -> rotate_left (counter+1)(h::newlist)(to_concat) tl
	in rotate_left 0 [] [] list

let () =
  	let myList = [1; 2; 3; 4; 5; 6; 7; 8; 9] in
  	let positionsToRotate = 3 in
  	let rotatedList = rotate_left myList positionsToRotate in
  	Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
  	Printf.printf "Rotated List: [%s]\n" (String.concat "; " (List.map string_of_int rotatedList))
