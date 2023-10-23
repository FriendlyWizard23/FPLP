let countNumbers list =
	let rec co occur prec list =
		match occur,list with
		| _ , [] -> occur							(* Se sono arrivato alla fine della mia lista di numeri dei quali contare occorrenze*)
		| _ , h::tl when h!=prec -> co (1::occur) h tl				(* Se sono al cambio di un numero, ovvero passo da un numero della lsita principale ad un altro, contateno uno alle occorrenze e vado avanti*)
		| h1::tl1 , h2::tl2 when h2 = prec -> co ((h1+1)::tl1) h2 tl2		(* Se nella lista devo contare un elemento che ho gia', allora sommo 1 alla testa e poi dopo concateno la testa sommata alla coda*)
		| _ , h::tl when h = prec -> co (1::occur) h tl				(* Se sono all'inizio della ricorsione, aggiungo 1 e vado avanti*)
		| _ -> raise(Failure "List error!")		
	in match list with
	| [] -> []
	| h::tl -> co [] (List.hd list) list
;;

let rec stampa_lista lst =
	match lst with
  	| [] -> ()
  	| testa :: resto ->
    		print_int testa;  (* Stampare l'elemento corrente *)
    		print_string " ";  (* Aggiungere uno spazio tra gli elementi *)
    		stampa_lista resto  (* Chiamata ricorsiva per il resto della lista *)
;;

let () =
	let mainlist = [] in
	let counters = countNumbers mainlist in
	stampa_lista counters ;;

