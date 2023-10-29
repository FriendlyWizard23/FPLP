let ispalindrome list =
	let rec ispalindrome reverse list =
		match (reverse,list) with
		| [],[]->1
		| h1::tl1,h2::tl2 when h1=h2 -> ispalindrome tl1 tl2
		| h1::tl1,h2::tl2 when h1<>h2 -> 0
		| _ -> raise (Failure "List error!")
	in ispalindrome (List.rev list) list


let () =
let pal = ispalindrome [1;2;3;4;3;2;1] in
print_int pal ;
let pal = ispalindrome [1;2;3;4;5;] in
print_int pal ;;

