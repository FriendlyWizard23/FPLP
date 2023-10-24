let reverse list = 
	let rec reverse newlist = function
	| [] -> newlist
	| h::tl -> reverse (h::newlist) tl
	in reverse [] list

let rec stampa_lista lista =
  match lista with
  | [] -> ()
  | testa :: coda ->
    print_int testa;
    print_string " ";
    stampa_lista coda
;;

let () =
	stampa_lista (reverse [1;2;3;4;5;6;]) ;;
