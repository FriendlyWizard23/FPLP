module Stack = struct
	exception Empty
	type 'a stack = 'a list
	let make:'a stack = []
	let size queue = (List.length queue)
	let is_empty (s: 'a stack) = s = [] 
	let push el (s:'a stack):'a stack = el::s
	let size (s: 'a stack) = List.length s
	let pop (s: 'a stack) =
		let rec pop = function
		| [] -> raise(Empty)
		| h::tl-> (h,tl)
		in pop s
	end ;;

let () =
  let s = Stack.make in
  print_string "Stack is empty: ";
  print_endline (string_of_bool (Stack.is_empty s));
  print_string "Stack size: ";
  print_int (Stack.size s);
  print_newline ();

  let s = Stack.push 1 s in
  print_string "Added 1 to the stack. Stack is empty: ";
  print_endline (string_of_bool (Stack.is_empty s));
  print_string "Stack size: ";
  print_int (Stack.size s);
  print_newline ();

  let s = Stack.push 2 s in
  print_string "Added 2 to the stack. Stack is empty: ";
  print_endline (string_of_bool (Stack.is_empty s));
  print_string "Stack size: ";
  print_int (Stack.size s);
  print_newline ();

  let (top, s) = Stack.pop s in
  print_string "Popped top element: ";
  print_int top;
  print_newline ();
  print_string "Stack size: ";
  print_int (Stack.size s);
  print_newline ();

  let (top, s) = Stack.pop s in
  print_string "Popped top element: ";
  print_int top;
  print_newline ();
  print_string "Stack is empty: ";
  print_endline (string_of_bool (Stack.is_empty s));
  print_string "Stack size: ";
  print_int (Stack.size s);
  print_newline ();

  try
    let _ = Stack.pop s in
    print_endline "Popped from an empty stack, expected Empty exception.";
  with
  | Stack.Empty -> print_endline "Caught Empty exception as expected."
  | _ -> print_endline "Unexpected exception."
;;

