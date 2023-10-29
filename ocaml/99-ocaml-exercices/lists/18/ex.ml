let slice list first last = 
	let rec slice counter newlist = function
		| [] -> List.rev newlist
		| h::tl when ((counter >= first) && (counter <= last)) -> slice (counter+1) (h::newlist) tl
		| h::tl -> slice (counter+1) newlist tl
	in slice 1 [] list

let () =
	let myList = [1; 2; 3; 4; 5; 6; 7; 8; 9] in
  	let firstIndex = 2 in
  	let lastIndex = 5 in
  	let slicedList = slice myList firstIndex lastIndex in
  	Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
  	Printf.printf "Sliced List: [%s]\n" (String.concat "; " (List.map string_of_int slicedList))
