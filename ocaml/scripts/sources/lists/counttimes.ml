let list=[1;56;23;45;87;9;23;4;65;1;23;1;1] ;;

let count_element list num = 
	let rec count tot num = function
		| [] -> tot
		| h::tl -> if (h==num) then count (tot+1) num tl else count tot num tl
	in count 0 num list ;;

let tot = count_element list 1 ;;
print_int tot ;;
