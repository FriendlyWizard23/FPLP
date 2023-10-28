let len_sort list = 
	let rec divide pivot greater smaller= function
	| [] -> (greater,smaller)
	| h::tl when (List.length h)>pivot -> divide pivot (h::greater) smaller tl
	| h::tl -> divide pivot greater (h::smaller) tl
	in
	let rec quicksort = function
	| [] -> []
	| h::tl -> let greater,smaller = divide (List.length h) [] [] tl in List.append (quicksort smaller) (h::(quicksort greater))
	in quicksort list

let frequency_sort list =	
	let rec concat_unroll mainlist = function
	| [] -> mainlist
	| h::tl -> concat_unroll (h::mainlist) tl
	in
	let rec unroll newlist = function
	| [] -> newlist
	| h::tl -> unroll (concat_unroll newlist h) tl
	in
	let rec generate_mega_list prev_len aux_list megalist = function
	| [] -> unroll [](len_sort megalist)
	| [el]-> generate_mega_list (List.length el)aux_list((el::aux_list)::megalist)[]
	| h::tl when (List.length h)=prev_len -> generate_mega_list (List.length h) (h::aux_list) (megalist) tl
	| h::tl -> generate_mega_list (List.length h) ([h]) (aux_list::megalist) tl
	in generate_mega_list (List.length list) [][] (len_sort list)
	
	

let () =
  let myList = [["apple"; "banana"];["toxic"; "gas"];["fucking"; "hate"]; ["cherry"; "date"; "elderberry"]; ["fig"]; ["grape"; "kiwi"]; ["lemon"]; ["mango"; "orange"; "papaya"]] in
  let sortedList = frequency_sort myList in
  Printf.printf "Original List:\n";
  List.iter (fun sublist -> Printf.printf "[%s]\n" (String.concat "; " sublist)) myList;
  Printf.printf "\nSorted List:\n";
  List.iter (fun sublist -> Printf.printf "[%s]\n" (String.concat "; " sublist)) sortedList
