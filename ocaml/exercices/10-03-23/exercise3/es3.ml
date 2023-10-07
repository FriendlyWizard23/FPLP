type matrix =
	| Zeroes of int * int * int list list
	| Identity of int * int list list
	| Init of int * int list list
	| Transpose of int list list
;;

(* FUNZIONI PER GENERARE LA MATRICE *)

(*	permette di generare una lista di liste.
	Quello che io faccio e' utilizzare init che prende due parametri x,y 
	Permette di generare una lista di 
	lunghezza x contenente i valori y
	quindi una lista di n elementi contenenti una lista di m elementi 0

 *)

let zeroes n m = Zeroes (n,m,(List.init n (fun _ -> List.init m (fun _ -> 0))))

(* 	Primo elemento e' ovviamente la dimensione, il secondo elemento e' 
	una funzione che ci dice come produrre gli elementi con i quali vogliamo popolare la lista 
	Sono funzioni anonime, non necessitano del nome
*)

let identity n = Identity (n,(List.init n (fun i ->List.init n (fun j -> if i==j then 1 else 0))))

(* Faccio giri strani per permettermi di avere una matrice che va da 1 ad n *)

let init n = Init (n,(List.init n (fun i ->List.init n (fun j -> j+1+(n*i)))))

(* Il ragionamento in sintesi e' quello che io ho una matrice nxm ad esempio 3x4 

	[1  2  3]					[1 4 7 10]
	[4  5  6]		e deve diventare	[2 5 8 11]
	[7  8  9]					[3 6 9 12]
	[10 11 12]

	quindi si scorrono tutte le liste della matrice iniziale e man mano si aggiungono gli elementi in posizione j
	alla posizione iesima della nuova matrice. Tutto questo tramite init e nth

*)


let transpose = function
	| Zeroes (n,m,content) -> List.init m (fun j -> List.init n (fun i -> List.nth (List.nth content i) j))
        | Identity (n,content) -> List.init n (fun j -> List.init n (fun i -> List.nth (List.nth content i) j))
        | Init (n,content) -> List.init n (fun j -> List.init n (fun i -> List.nth (List.nth content i) j))
	| _ -> raise(Invalid_argument "Invalid Matrix Type")

(* PRINTING FUNCTIONS BC: THEY ARE I M P U R E!!! *)

let rec print_matrix_row row =
	match row with
  	| [] -> ()
  	| hd::tl -> Printf.printf "%2d " hd; print_matrix_row tl

let rec print_matrix_rows matrix =
  	match matrix with
  	| [] -> ()
  	| row::rest -> print_matrix_row row; print_newline (); print_matrix_rows rest

let print_matrix matrix =
	match matrix with
  	| Zeroes (_, _, data) 
	| Identity (_, data) 
	| Init (_, data)-> print_matrix_rows data 
	| Transpose (data) -> print_matrix_rows data


let matrix1 = zeroes 3 4;;
print_matrix matrix1 ;;
print_newline ();;

let matrix2 = identity 4 ;;
print_matrix matrix2 ;;
print_newline() ;;

let matrix3 = init 10;;
print_matrix matrix3 ;;
print_newline ();;

let matrix4 = transpose matrix1 ;;
print_matrix matrix3 ;;
print_newline();;
