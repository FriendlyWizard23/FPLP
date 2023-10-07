let slice i j list =
	let rec slice count res = function
	| hd::tl when count < i	-> slice (count+1) res tl
	| _	 when count == j -> (List.rev res)
	| hd::tl		 -> slice (count+1) (hd::res) tl
	in slice 0 [] l ;;

