let deleteconsecutives list =
	let rec delcons cleanlist last = function
		| [] -> List.rev cleanlist
		| h::tl when h=last ->delcons cleanlist h tl
		| h::tl when h<>last -> delcons (h::cleanlist) h tl
		| _ -> raise (Failure "Error while parsing list")	
	in 
	match list with
	| [] -> []
	| _ -> delcons [List.hd list] (List.hd list) list

let rec stampa_lista = function
  | [] -> ()
  | x::rest -> 
    print_int x;   (* Stampa l'elemento corrente *)
    print_string " ";   (* Stampa uno spazio tra gli elementi *)
    stampa_lista rest   (* Chiamata ricorsiva sulla coda della lista *)


let () = 
	let cleaned = deleteconsecutives [1;1;1;2;3;4;5;5;5;6;7;7;7;7;7;7;7;7;8] in
	stampa_lista cleaned ;;
