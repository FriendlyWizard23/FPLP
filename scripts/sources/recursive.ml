let rec fact(n) = if n<1 then 1 else n*fact(n-1) ;;

let result = fact(10) ;;

print_string "\n" ;;
print_int result ;;
print_string "\n" ;;
