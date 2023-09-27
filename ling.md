# Appunti di Linguaggi di programmazione
## Link utili
- https://v2.ocaml.org/manual/patterns.html

## Informazioni
- Lunedi:
- Martedi:

# LEZIONE 1: Introduzione
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
# LEZIONE 1: OcaML
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

### Binding
- è possibile assegnare a delle incognite un valore ad esempio

```
# let y = 5 ;;
val y : int = 5

# let succ x = x + y ;;
val succ : int -> int = <fun>

# succ 5 ;;
- : int = 10
```
### Composizione
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



### Pattern matching
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
### Exceptions
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

### Utilizzo di piu parametri
- è possibile utilizzare piu parametri per le funzioni nel seguente modo
```
let sumtwo = fun x z -> x + z ;;
let result4 = sumtwo 4 5 ;;
```

### Ricorsione
- la ricorsione funziona come negli altri linguaggi
- bisogna diversificare come sempre caso base e passo ricorsivo etc
**esempio fattoriale e fibonacci**
```
let rec fact(n) = if n<=1 then 1 else n*fact(n-1);;
let res = fact(5) ;;

let rec fibonacci(n) = if n<2 then n else fibonacci(n-1)+fibonacci(n-2);;
let res2 = fibonacci(5) ;;
print_int(res2) ;;
```
