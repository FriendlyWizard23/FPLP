let phi m = 
	let is_prime number=
       		let rec is_prime counter =
        	match number with
        	| value when ((counter<number) && ((number mod counter)=0) && (counter<>1)) -> false
        	| value when (counter<number) -> is_prime (counter+1)
        	| _ -> true
        	in is_prime 1	
	in
	let rec getprimefactors m counter primefactors =
	match counter with
	| 1 -> primefactors
	| counter when ((is_prime counter)=true)&&((m mod counter) = 0 ) -> getprimefactors (m/counter)(counter-1)(float_of_int(counter)::primefactors)
	| counter -> getprimefactors m (counter-1)primefactors
	in
	
	let rec calculate_euler calculated = function
	| [] -> int_of_float(ceil(calculated *. float_of_int(m))) 
	| h::tl -> calculate_euler (calculated *. (1. -. (1. /. h))) tl
	
	in 
	match m with
  	| 1 -> 1
  	| m when ((is_prime m) = true) ->(m - 1)
  	| _ -> calculate_euler 1.0 (getprimefactors m m [])


let test_phi () =
  let test_cases = [
    (1, 1);
    (2, 1);
    (3, 2);
    (4, 2);
    (5, 4);
    (6, 2);
  ] in

  let test_passed = ref true in

  List.iter
    (fun (m, expected_phi) ->
      let result = phi m in

      if result = expected_phi then
        Printf.printf "Test passed: phi(%d) = %d\n" m expected_phi
      else begin
        Printf.printf "Test failed: phi(%d) = %d (Expected: %d)\n" m result expected_phi;
        test_passed := false
      end
    )
    test_cases;

  if !test_passed then
    Printf.printf "Tutti i test sono passati!\n"
  else
    Printf.printf "Almeno un test è fallito.\n"

let () = test_phi ()

