let coprime vala valb =
        let rec euclides vala valb =
        match (vala,valb) with
        | vala,valb when valb=0 -> vala
        | vala,valb -> euclides valb (vala mod valb)
        in 
	match (euclides vala valb) with
	| 1 -> true
	| _ -> false


let test_coprime () =
  let test_cases = [
    (10, 5, false);
    (14, 28, false);
    (21, 14, false);
    (17, 5, true);
    (100, 75, false);
  ] in

  let test_passed = ref true in

  List.iter
    (fun (a, b, expected_result) ->
      let result = coprime a b in
      if result = expected_result then
        Printf.printf "Test passed: coprime %d %d = %b\n" a b expected_result
      else begin
        Printf.printf "Test failed: coprime %d %d = %b (Expected: %b)\n" a b result expected_result;
        test_passed := false
      end
    )
    test_cases;

  if !test_passed then
    Printf.printf "Tutti i test sono passati!\n"
  else
    Printf.printf "Almeno un test è fallito.\n"

let () = test_coprime ()
