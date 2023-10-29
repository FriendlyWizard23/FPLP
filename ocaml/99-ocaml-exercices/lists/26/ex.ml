let fullperm list =
	let rec permute perms element = function
	| [] -> perms
	| h::tl when h<>element -> permute ([element;h]::perms) element tl
	| h::tl -> permute perms element tl 
	in
	let rec fullperm newlist = function
	| [] -> List.rev newlist
	| h::tl -> fullperm (permute newlist h list) tl
	in fullperm [] list


let () =
  let myList = [1; 2; 3; 4; 5; 6; 7] in
  let permutations = fullperm myList in
  Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
  Printf.printf "Permutations: [\n";
  List.iter (fun perm -> Printf.printf "  [%s]\n" (String.concat "; " (List.map string_of_int perm))) permutations;
  Printf.printf "]\n"
