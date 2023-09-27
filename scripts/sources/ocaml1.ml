let y=8 ;;
let addone x = x + 1 ;;
let addy x = x + y ;;

let choose x z =
	match x with
	| "one" -> addone z
	| "y" -> addy z
	| _ -> raise (Invalid_argument "bool_of_string");;

let result = choose "one" 10;;
print_int result;;
print_string "\n" ;;
