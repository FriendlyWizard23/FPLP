let rec fact(n) = if n<=1 then 1 else n*fact(n-1);;
let res = fact(5) ;;

let rec fibonacci(n) = if n<2 then n else fibonacci(n-1)+fibonacci(n-2) ;;
let res2 = fibonacci(5) ;;
print_int(res2) ;;
