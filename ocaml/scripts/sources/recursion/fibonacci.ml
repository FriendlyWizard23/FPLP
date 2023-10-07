let rec fib n = 
	if n<2 then 
		n 
	else(
		fib(n-1)+fib(n-2)
	)

let rec print_seq n =
	print_int(fib n);
	print_string "\n"; 
	if n < 2 then
		n
	else
		print_seq (n-1)	

let result = print_seq(10);;
