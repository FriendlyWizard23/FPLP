let unholy_chars = [' '; '\t'; '\n'; '\r'; '.'; ','; '!'; '?'; '('; ')'; '['; ']'; '{'; '}'; ':'; ';'; '"'; '\'']

let rec is_unholy_char char = function
	| [] -> false
	| h::tl -> if char==h then true else is_unholy_char char tl

let clear_string string unholy_chars =
	let rec clear_string_rec index count length cleared= 
	match index with 
	| i when i>length ->String.lowercase_ascii cleared
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
	in is_palindrome (clear_string string unholy_chars)0 ((String.length string )-1)


let s1 = "Is this string Unholy" ;;
let s2 = clear_string s1 unholy_chars ;;
print_string s2 ;;
