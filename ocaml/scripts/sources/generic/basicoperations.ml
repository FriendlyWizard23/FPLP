let addone x = x + 1 ;;
let addone2 = fun x -> x + 1 ;;

let result = addone 10 ;;
let result2 = addone2 10 ;;
let result3 = (fun x -> x + 1)10 ;;
let result4 = addone(addone2((fun x->x + 1)10));;

let result = addone 15 ;;

let y = -20 ;;
let ph = 30 ;;
let subtract = (fun x->x-ph)result4;;

print_string "\n" ;;
print_int result ;;
print_string "\n" ;;
print_int result2 ;;
print_string "\n" ;;
print_int result3 ;;
print_string "\n" ;;
print_int result4 ;;
print_string "\n" ;;
print_int subtract ;;
print_string "\n" ;;
