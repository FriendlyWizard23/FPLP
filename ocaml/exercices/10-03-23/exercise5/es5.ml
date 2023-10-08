let unholy_chars = [' '; '\t'; '\n'; '\r'; '.'; ','; '!'; '?'; '('; ')'; '['; ']'; '{'; '}'; ':'; ';'; '"';]

let rec is_unholy_char char = function
	| [] -> false
	| h::tl -> if char==h then true else is_unholy_char char tl

let clear_string string unholy_chars =
	let rec clear_string_rec index count length cleared= 
	match index with 
	| i when i>length -> cleared
	| _ -> 
		if (is_unholy_char string.[index] unholy_chars)<>true then 
			clear_string_rec (index + 1) count length (cleared ^ (String.make 1 string.[index])) 
		else  
			clear_string_rec (index + 1) (count + 1) length cleared
 
	in clear_string_rec 0 0((String.length string)-1) ""
	

let is_palindrome string unholy_chars=
	let rec is_palindrome string first last=
		match (first,last) with
		| (f,l) when f>=l -> true
		| (f,l) when string.[f]=string.[l] -> is_palindrome string(first+1)(last-1)
		| _ -> false
	in is_palindrome (clear_string string unholy_chars)0 ((String.length (clear_string string unholy_chars) )-1)


let string_to_list string =
	let rec stl index length list=
		match index with
		| i when i>length -> list
		| _ -> stl (index+1)length((string.[index])::list)
	in stl 0 ((String.length string)-1) [] 

let operatorMinus string to_delete_string = clear_string string (string_to_list to_delete_string) ;;

let print_bool = function
	| true -> print_string ("True\n")
	| false -> print_string ("False\n")


let read_lines_from_file filename =
	let lines = ref [] in
  	let channel = open_in filename in
  	try
  	  while true do
      		let line = input_line channel in
      		lines := line :: !lines
  	done;
    	List.rev !lines
  	with
  	| End_of_file -> close_in channel;
    	List.rev !lines ;;

let rec quicksort = function
  	| [] -> []
  	| pivot::rest ->
      		let smaller, greater = List.partition (fun x -> x <= pivot) rest
	in List.append(quicksort smaller)(List.append([pivot])(quicksort greater));;

let list_length list =
	let rec list_length count list= 
	match list with
	|[] -> count
	| h::tl -> list_length (count+1)tl
	in list_length 0 list


let print_char_list char_list =
  List.iter (fun c -> print_char c; print_string " ") char_list;
  print_newline ()
;;

let is_anagramma string1 string2 = 
	let rec is_anagramma list1 list2 =
		match (list1,list2) with
		|(l1,l2) when list_length(l1)<>list_length(l2) -> false
		|([],[]) -> true
		|(h::tl,h2::tl2) when h=h2 ->is_anagramma tl tl2
		| _ -> false 
        in is_anagramma (quicksort (string_to_list string1)) (quicksort(string_to_list string2))
;;

let match_anagrams string list = 
	let rec anagrams matches = function
	| [] -> matches
	| h::tl when (is_anagramma string h) -> anagrams (h::matches) tl
	| h::tl  -> anagrams matches tl
	in anagrams [] list


let s1 = "ot tt. o" ;;
let s3 = is_palindrome s1 unholy_chars ;;
let s4 = operatorMinus "Walter Cazzola" "abcwxyz" ;;
print_string s4 ;;
print_newline();;
let filename = "file.txt" ;;
let lines = read_lines_from_file filename ;;
List.iter print_endline (match_anagrams "ciao" lines);;
