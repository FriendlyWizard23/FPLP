let remove list k = 
	let rec remove newlist counter = function
	| [] -> List.rev newlist
	| h::tl when counter <> k -> remove (h::newlist)(counter+1)tl
	| h::tl -> remove (newlist)(counter+1)tl
	in remove [] 0 list

let () =
  let myList = [1; 2; 3; 4; 5; 6; 7; 8; 9] in
  let indexToRemove = 2 in
  let modifiedList = remove myList indexToRemove in
  Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
  Printf.printf "Modified List: [%s]\n" (String.concat "; " (List.map string_of_int modifiedList))
