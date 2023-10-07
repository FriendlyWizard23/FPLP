let list = [2;4;17;6;3;8;9;10;200;99;30]
let rec find_in_list list num =
	if list == [] then
		false
	else num == List.hd(list) || find_in_list (List.tl list) num;;

let found x = 
	match x with
	| true -> "Presente"
	| false -> "Non presente" ;;

let res=found (find_in_list list 4) ;;
print_string res ;;
