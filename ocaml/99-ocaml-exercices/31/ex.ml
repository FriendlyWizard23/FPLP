let is_prime number=
	let rec is_prime counter = 
	match number with
	| value when ((counter<number) && ((number mod counter)=0) && (counter<>1)) -> false 
	| value when (counter<number) -> is_prime (counter+1) 
	| _ -> true
	in is_prime 1
let () =
  let number_to_test = 17989 in
  let result = is_prime number_to_test in
  Printf.printf "Is %d prime? %b\n" number_to_test result

