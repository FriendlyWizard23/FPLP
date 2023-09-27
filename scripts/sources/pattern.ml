let booleana x=
        match x with
        | "false" -> "falso"
        | "true" -> "vero"
        | _ -> raise(Invalid_argument "Not of boolean type like")
;;

let invert = function
	| true -> "Its true!\n"
	| false -> "Its false!\n" 
;;
let y=20 ;;
let addy = fun x -> x+y ;;
let sumtwo = fun x z -> x + addy z ;;

let result = booleana "false" ;;
let result2 = booleana "true" ;;
let result4 = sumtwo 4 5 ;;

let result3=invert true ;;
print_string result3 ;;
print_int result4 ;;
print_string "\n" ;;
