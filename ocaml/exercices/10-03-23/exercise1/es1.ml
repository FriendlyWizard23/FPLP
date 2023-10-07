let alkaline_earth_metals = [4;12;20;38;56;88];;
let noble_gases = [2;10;18;36;54;86];;
let find_max list = 
	let rec maximum max = function
		| [] -> max 
		| h::tl ->if h>max then maximum h tl else maximum max tl		
	in maximum (List.hd list) (List.tl list) ;;


let rec quicksort = function
  | [] -> []
  | pivot::rest ->
      let smaller, greater = List.partition (fun x -> x <= pivot) rest 
  in List.append(quicksort smaller)(List.append([pivot])(quicksort greater));;

let print list =  
	let open Printf in
  	List.iter (fun x -> printf "%d " x) list;
  	print_newline ();;

let sortedAEM = quicksort alkaline_earth_metals ;;
let sortedNG = quicksort noble_gases ;;
let allsorted = List.append(sortedAEM)(sortedNG) ;;
let merged = quicksort allsorted ;;

print sortedAEM ;;
print sortedNG ;;
print merged ;;

