let agglomerate list = 
	let rec agglomerate wastelist aggled last = function
	| [] -> aggled
	| h::tl when h=last -> agglomerate (h::wastelist) aggled h tl 
	| h::tl when h<>last -> agglomerate [h] (wastelist::aggled) h tl
	| _ -> raise (Failure "Error while parsing lists")
	in agglomerate [List.hd list] [] (List.hd list) list


let test_agglomerate () =
  let input1 = [1; 1; 2; 3; 3; 4; 4; 4; 5] in
  let output1 = agglomerate input1 in
  Printf.printf "Input: %s\n" (String.concat "; " (List.map string_of_int input1));
  Printf.printf "Output: %s\n" (String.concat "; " (List.map string_of_int (List.flatten output1)));
  Printf.printf "\n";

  let input2 = [10; 20; 20; 30; 30; 30] in
  let output2 = agglomerate input2 in
  Printf.printf "Input: %s\n" (String.concat "; " (List.map string_of_int input2));
  Printf.printf "Output: %s\n" (String.concat "; " (List.map string_of_int (List.flatten output2)));
  Printf.printf "\n"

let () =
  test_agglomerate ()
