Random.self_init ;;
let extract_random list n = 
	let () = Random.self_init () in
	let rec extract_random newlist n = 
	match n with
	| n when n>0 -> extract_random (List.nth list (Random.int ((List.length list)-1))::newlist)(n-1)
	| _ -> List.rev newlist
	in
	match n with
	| n when n>0 -> extract_random [] n
	| _ -> raise (Failure "n Error" )

let () =
  	let myList = [10; 20; 30; 40; 50; 60; 70; 80; 90] in
  	let countToExtract = 30 in
    	let extractedList = extract_random myList countToExtract in
    	Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
    	Printf.printf "Extracted List: [%s]\n" (String.concat "; " (List.map string_of_int extractedList))
