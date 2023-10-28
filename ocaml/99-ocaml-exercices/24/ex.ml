let lotto n m =
	let rec lotto n newlist =
	match n with
	| n when n>0 -> let () = Random.self_init () in lotto (n-1) ((Random.int m)::newlist)
	| _ -> newlist 
	in lotto n []

let () =
  	let numberOfDraws = 6 in
  	let maxNumber = 49 in
  	let result = lotto numberOfDraws maxNumber in
  	Printf.printf "Lottery Numbers: [%s]\n" (String.concat "; " (List.map string_of_int result))
