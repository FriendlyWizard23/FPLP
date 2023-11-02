let multiagglomerate list=
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
        let rec multiagglomerate newlist prev counter = function
        | [] -> List.rev(((counter),prev)::newlist)
	| h::tl when h=prev -> multiagglomerate newlist h (counter+1) tl
	| h::tl -> multiagglomerate ((counter,prev)::newlist) h 1 tl
	in 
        match list with
        |[] -> raise(Failure "Empty list" )
        |h::tl -> multiagglomerate [] h 0 (sortlist list)


let () =
	let mainlist = [1; 1; 2; 1; 3; 1; 5; 6; 2; 3; 7; 8; 8; 6] in
	let l = multiagglomerate mainlist in
	print_string "Main List: ";
	List.iter (fun x -> Printf.printf "%d " x) mainlist;
	print_string "\n";
	print_string "Multiagglomerated List: ";
	List.iter (fun (x, y) -> Printf.printf "[%d,%d] " x y) l;
	print_string "\n";
