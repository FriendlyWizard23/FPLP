let rec facto n = 
	if n<=1 then n 
	else n*facto(n-1)
;;
print_int (facto(10));;

