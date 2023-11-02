
let nbiggest list n=
	let rec greater newlist pivot = function
	| [] -> List.rev newlist
	| h::tl when h>=pivot -> greater (h::newlist) pivot tl
	| h::tl -> greater newlist pivot tl
	in
	
	let rec smaller newlist pivot = function
	| [] -> List.rev newlist
        | h::tl when h<pivot -> smaller (h::newlist) pivot tl
        | h::tl -> smaller newlist pivot tl
	in
	let rec sortlist = function
	| [] -> []
	| h::tl -> List.append (sortlist(smaller [] h tl))(List.append [h] (sortlist(greater [] h tl)))
	in	
	let rec nbiggest newlist n= function
	| h::tl when n>0 -> nbiggest (h::newlist) (n-1) tl
	| h::tl -> newlist
	| _ -> raise(Failure "List failure")	
	in 
	match n,list with
	| _,[] -> raise(Failure "Empty list" )
	| n,_ when n>(List.length list) -> raise(Failure "n is too big!")
	| n,_ when n<=0 -> raise(Failure "n is too small!")
	| _ ->nbiggest [] n (List.rev(sortlist list))


let rec print_list lst =
  match lst with
  | [] -> ()
  | h::t ->
    Printf.printf "%d " h;
    print_list t

let () =
  let input = [4; 7;8;13;-2;6;-10] in
  let n = 5 in
  let result = nbiggest input n in
  Printf.printf "Input: ";
  print_list input;
  Printf.printf "n: %d\n" n;
  Printf.printf "Result: ";
  print_list result;
  Printf.printf "\n"
