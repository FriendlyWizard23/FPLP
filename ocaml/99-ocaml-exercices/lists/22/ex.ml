let create_range idx1 idx2 = 
	let rec create_range idx1 idx2 newlist =
	match (idx1,idx2) with
	| ix1, ix2 when ix1<=ix2 -> create_range (ix1+1) ix2 (ix1::newlist)
	| _ -> List.rev newlist
	in
	match (idx1,idx2) with
	| ix1,ix2 when ix1>ix2 -> List.rev (create_range ix2 ix1 [])
	| ix1,ix2 -> create_range ix1 ix2 []

let () =
  	let startIndex = 8 in
  	let endIndex = 3 in
  	let rangeList = create_range startIndex endIndex in
  	Printf.printf "Start Index: %d\n" startIndex;
  	Printf.printf "End Index: %d\n" endIndex;
  	Printf.printf "Created Range: [%s]\n" (String.concat "; " (List.map string_of_int rangeList))
