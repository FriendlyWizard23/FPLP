let factors m =
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
	let rec factors newlist counter last = function
	| [] -> List.rev ((counter,last)::newlist)
	| h::tl when h<>last->factors ((counter,last)::newlist) 1 h tl
	| h::tl -> factors (newlist) (counter+1) h tl
	in 
	match m with
	| 1 -> [(1,1)]
	|_ -> factors [] 0 (List.hd(primefactors [] m m)) (primefactors [] m m) 

let test_factors () =
  let test_cases = [
    (1, [(1, 1)]);
    (2, [(1, 2)]);
    (10, [(1,2); (1,5)]);
    (12, [(2, 2); (1, 3)]);
    (28, [(2, 2); (1, 7)]);
    (37, [(1, 37)]);
  ] in

  let test_passed = ref true in

  List.iter
    (fun (m, expected_factors) ->
      let result = factors m in

      if result = expected_factors then
        Printf.printf "Test passed: factors(%d) = %s\n" m (String.concat "; " (List.map (fun (f, c) -> Printf.sprintf "(%d, %d)" f c) expected_factors))
      else begin
        Printf.printf "Test failed: factors(%d) = %s (Expected: %s)\n" m (String.concat "; " (List.map (fun (f, c) -> Printf.sprintf "(%d, %d)" f c) result)) (String.concat "; " (List.map (fun (f, c) -> Printf.sprintf "(%d, %d)" f c) expected_factors));
        test_passed := false
      end
    )
    test_cases;

  if !test_passed then
    Printf.printf "Tutti i test sono passati!\n"
  else
    Printf.printf "Almeno un test è fallito.\n"

let () = test_factors ()
