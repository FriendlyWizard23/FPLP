let insert_at element k list =
	let rec insert_at counter newlist = function
	| [] -> List.rev newlist 
	| h::tl when counter=k -> insert_at (counter+1) (h::element::newlist) tl
	| h::tl -> insert_at (counter+1) (h::newlist) tl
	in
	match k with
	| value when ((value<0)||(value>(List.length list))) -> raise(Failure "Index error")
	| _ -> insert_at 1 [] list

let () =
  let myList = [1; 2; 3; 4; 5; 6; 7; 8; 9] in
  let elementToInsert = 10 in
  let indexToInsert = 2 in
  let modifiedList = insert_at elementToInsert indexToInsert myList in
  Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
  Printf.printf "Modified List: [%s]\n" (String.concat "; " (List.map string_of_int modifiedList))
