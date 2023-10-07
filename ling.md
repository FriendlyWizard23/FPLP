# Appunti di Linguaggi di programmazione
## Link utili
- https://v2.ocaml.org/manual/patterns.html

## Informazioni
- Lunedi:
- Martedi:

## Definizione ed intro
- non ci sono cicli, loop, for etc
- utilizzo di funzioni e basta
- scrivere funzioni senza side effects
- scrivere codice "in sicurezza"
- non ci sono variabili che vengono ritornate, non ci possono essere cose come leak di memoria etc. 
### come metto insieme le funzioni?
> tramite una **composizione di funzioni** 
### Strutture di controllo
- si utilizza solo la ricorsione per elementi come cicli
### Per quale ragione fare programmazione funzionale
- non essendoci elementi possiblimente problematici come assegnamenti etc, io posso esser sicuro che non avrò problemi di questo genere, che sono tra i piu comuni. Posso risolvere piu facilmente errori

## Kambda Calculus
### Composizione
- composto da 4 elementi
    - Costanti
    - Variabili
    - Lambda o altr isimboli
    - Parentes
### Definizioni
- Se x è una variabile o una costante allora x è una delta-exporession
- Se x è una variabile e M è una delta espressione allora deltax.M è una deltra-expression
- se M ed N sono delle delta expressions allora (MN) è una delta expression

...
# LINGUAGGIO 1: OcaML
- ML è un acronimo di MetaLanguage, è una astrazione del delta-calculus polimorfo
- ha una serie di caratteristiche:
    - **eager evaluation** = Tutte le sub-expressions sono sempre evaluated. è possibile anche effettuare "Lazy Evaluation"
    - **Call by vaue** evaulation strategy
    -**First class functions**
    -Molto altro
- OCaML viene installato con
    - un interprete (ocaml)
    - un compilatore (ocamlc)
## Elementi di programmazione
- unit = come se fosse il void della imperativa
- per fare andare le frecce su ocaml bisogna fare ```mlwrap ocaml```
- le funzioni sono definite interamente dentro il loro nome:
    ```ocaml
    let succ = fun x->x+1;;
    let succ x = x+1;;
    let succ' = succ;; // posso fare un alias
    // posso fare chiamate in uno di questi modi:
    succ 2;;
    (fun x -> x+1) 2;;
    
    ```
- Di seguito i modi per definire una funzione 

1)  **let nome = fun x -> operazione ;;**
2)  **let nome x = operazione ;;**
3)  **( fun x -> operazione )valore_assegnamento_x ;;**
#### Esempio 1:
```
let succ = fun x -> x+1 ;;
let succ x = x+1 ;;

fanno esattamente la stessa cosa, e' possibile quindi utilizzare queste notazioni per scrivere una funzione. 

Per chiamarle con un parametro basta fare

succ 4 ;;

ora, un altro modo per creare una funzione e chiamarla con un parametro subito e'

( fun x -> x+3 )4 ;;

in questo caso mi restituira' 7
```

### BINDING
- è possibile assegnare a delle incognite un valore ad esempio

```
# let y = 5 ;;
val y : int = 5

# let succ x = x + y ;;
val succ : int -> int = <fun>

# succ 5 ;;
- : int = 10
```
### COMPOSIZIONE DI FUNZIONI
- ovviamente è possibile fare combinazione di piu funzioni
- ad esempio, dato succ che fa x+1, se volessi fare la funzione che mi stampa due numeri dopo la x, utilizzando succ, dovrei fare
```
# let succ x = x+1 ;;
val succ : int -> int = <fun>

# let succsucc x = succ (succ x) ;;
val succsucc : int -> int = <fun>

# succsucc 2 ;;
- : int = 4

```



### PATTERN MATCHING
- le espressioni possono essere definite da patern matching
- i pattern possono contenere costanti, tuple, records,costruttori varianti e nomi varianti
Quando un pattern viene matchato:
- la expression corrispondente viene restituita
- la clause "when" opzionale, è una guardia del sistema di matching, filtra match non desiderati
- 
- > RICHIEDE CHE SI UTILIZZI FUNCTION E NON FUN E BASTA se si utilizza la notazione con function
- come prima, è possibile utilizzare la notazione
- Esempio:
```
let invert x =
    match x with 
    | true -> false
    | false -> true ;;

let invert' = function
    true -> false | false -> true ;;
```

- in questo secondo caso il parametro è implicito!
### EXCEPTIONS
- è possibile "lanciare" le eccezioni tramite la call **raise**
- > raise (type "msg")
- **esempio**
```
let booleana x=
        match x with
        | "false" -> "falso"
        | "true" -> "vero"
        | _ -> raise(Invalid_argument "Not of boolean type like")
    ;;
    
```

### PARAMETRI
- è possibile utilizzare piu parametri per le funzioni nel seguente modo
```
let sumtwo = fun x z -> x + z ;;
let result4 = sumtwo 4 5 ;;
```

### RICORSIONE
- la ricorsione funziona come negli altri linguaggi
- bisogna diversificare come sempre caso base e passo ricorsivo etc
**esempio fattoriale e fibonacci**
```
let rec fact(n) = if n<=1 then 1 else n*fact(n-1)
let res = fact(5) 

let rec fibonacci(n) = if n<2 then n else fibonacci(n-1)+fibonacci(n-2)
let res2 = fibonacci(5) 
print_int(res2) 
```

### OPERATORE WHEN
- permette di fare una evalutation della condizione dopo il pattern match


### FUNZIONI PURE
- molto importante in OCAML il concetto di funzioni pure
- > *A pure function is one without any side effects. A side effect means that the function keeps some sort of hidden state inside it. strlen is a good example of a pure function in C. If you call strlen with the same string, it always returns the same length. The output of strlen (the length) only depends on the inputs (the string) and nothing else. Many functions in C are, unfortunately, impure. For example, malloc. If you call it with the same number, it certainly won't return the same pointer to you. malloc, of course, relies on a huge amount of hidden internal state (objects allocated on the heap, the allocation method in use, grabbing pages from the operating system, etc.).*

- il problema che sorge spontaneo è quello di utilizzare elementi come "print_int" all'interno di una funzione, poichee rendono la funzione impura.

- Per ovviare  a questo "problema" basta separare bene le unita' di lavoro, in questo caso volevo generare una funzione che stampasse la sequenza di fibonacci. Ho quindi
    1. Scritto la funzione ricorsiva fib che stampa il numero di fiboancci per quel numero.
    2. scritto print_req che mi stampa la sequenza di fibonacci da n ad 1.

```
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


```

- NB: **Non esistono cicli! tutto tramite ricorsione**


## COLLECTIONS

### LISTE
#### OPERATORE ::
- crea una lista da un singolo elemento ed una lista
- ad esepmio <code>1::[2;3]</code> crea la lista <code>[1;2;3]</code>
- si può utilizzare <code>1::[]</code> per creare una lista con il valore 1 al suo interno
- hanno un costruttore che di fatto e' il <code> :: </code>
- per istanziare una lista con dei valori basta utilizzare : <code> let list_name=[el1; el2; el3...] </code>

#### Esempio: Trovare numero di occorrenze di una stringa

```
let list=[1;56;23;45;87;9;23;4;65;1;23;1;1] ;;

let count_element list num =
        let rec count tot num = function
                | [] -> tot
                | h::tl -> if (h==num) then count (tot+1) num tl else count tot>
        in count 0 num list ;;

let tot = count_element list 1 ;;
print_int tot ;;
```
#### SLICING




### STRINGHE
- sono native di OCAML
- si possono fare operazioni:
    - ^ concatenaione
    - .[] accesso posizionale ai caratteri
- sono IMMUTABILI, non possono essere modificate
```
let s1 = "test" and s2 = "stringhe" ;;
val s1 : string = "stringa2" ;;

s1.[2] mi restituisce s

String.length(s) restituisce la lunghezza della stringa

```

### ARRAY
- sono mutabili
- hanno un tipo
```
let array = [ | 1;2;3|];;

posso accedere ai singoli elementi tramite

array.(2) ;;

posso sostituire elementi tramite operatore freccia

array.(2) <-- 5 ;;
```

### MATRIX
```
let a = Array.make 5 0 ;;

in questo modo genero un array su singola riga

è possibile anche concatenare
```

### RECORDS

```
type person = {name: string; mutable age: int} ;;

val p:person = {name = "Mario"; age=20} ;;

```

