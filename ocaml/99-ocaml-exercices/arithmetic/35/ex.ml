let primefactors m =
	let is_prime number=
                let rec is_prime counter =
                match number with
                | value when ((counter<number) && ((number mod counter)=0) && (counter<>1)) -> false
                | value when (counter<number) -> is_prime (counter+1)
                | _ -> true
                in is_prime 1
        in	
	let rec primefactors newlist counter newm= 
	match newm with
	| 1 -> (List.sort compare newlist)	
	| newm when ((is_prime counter) && ((newm mod counter) = 0 )) -> primefactors (counter::newlist) m (newm/counter)
	| newm -> primefactors (newlist) (counter-1) newm
	in
	match m with
	| 1 -> [1]
	| _ -> primefactors [] m m

let test_primefactors () =
  let test_cases = [
    (1, [1]);
    (2, [2]);
    (10, [2; 5]);
    (12, [2;2; 3]);
    (28, [2;2; 7]);
    (37, [37]); 
  ] in

  let test_passed = ref true in

  List.iter
    (fun (m, expected_factors) ->
      let result = primefactors m in

      if result = expected_factors then
        Printf.printf "Test passed: primefactors(%d) = [%s]\n" m (String.concat "; " (List.map string_of_int expected_factors))
      else begin
        Printf.printf "Test failed: primefactors(%d) = [%s] (Expected: [%s])\n" m (String.concat "; " (List.map string_of_int result)) (String.concat "; " (List.map string_of_int expected_factors));
        test_passed := false
      end
    )
    test_cases;

  if !test_passed then
    Printf.printf "Tutti i test sono passati!\n"
  else
    Printf.printf "Almeno un test è fallito.\n"

let () = test_primefactors ()

