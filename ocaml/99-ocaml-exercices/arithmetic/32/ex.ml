let euclides vala valb = 
	let rec euclides vala valb =
	match (vala,valb) with
	| vala,valb when valb=0 -> vala
	| vala,valb -> euclides valb (vala mod valb)
	in euclides vala valb


let test_euclides () =
  let test_cases = [
    (10, 5, 5);
    (14, 28, 14);
    (21, 14, 7);
    (17, 5, 1);
    (100, 75, 25);
  ] in

  let test_passed = ref true in

  List.iter
    (fun (a, b, expected_result) ->
      let result = euclides a b in
      if result = expected_result then
        Printf.printf "Test passed: euclides %d %d = %d\n" a b expected_result
      else begin
        Printf.printf "Test failed: euclides %d %d = %d (Expected: %d)\n" a b result expected_result;
        test_passed := false
      end
    )
    test_cases;

  if !test_passed then
    Printf.printf "Tutti i test sono passati!\n"
  else
    Printf.printf "Almeno un test è fallito.\n"

let () = test_euclides ()
