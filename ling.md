# Appunti di Linguaggi di programmazione
## Link utili
### OCAML
- https://v2.ocaml.org/manual/patterns.html
- https://cs3110.github.io/textbook/chapters/modules/functors.html
- https://courses.cs.cornell.edu/cs3110/2021sp/textbook/modules/signatures.html
- https://www.youtube.com/playlist?list=PLre5AT9JnKShBOPeuiD9b-I4XROIJhkIU
- https://ocaml.org/exercises
  
### ERLANG
- https://www.tutorialspoint.com/erlang/
- https://www.erlang.org/doc/reference_manual/data_types#tuple
- https://erlang.org/download/erlang-book-part1.pdf

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


### TUPLE
- liste di dimensione fissa 
- eterogenee
```

let tuple = (5,'char', "This is a string",[1;2;3;4],3.14) ;;
let pair = (1,"ciao") ;;
```

#### TUPLE PAIR
- tuple composte da due elementi
- premettono di utilizzare due operatori

```
fst pair ;; mi restituisce il primo elemento del pair
snd pair ;; mi restituisce il secondo elemento del pair. 
```
### ARRAY
- strutture che ci permettono di accedere algi elementi direttamente
- sono mutabili
- hanno un tipo
```
let array = [ | 1;2;3|];;

posso accedere ai singoli elementi tramite

array.(2) ;;

posso sostituire elementi tramite operatore freccia

array.(2) <-- 5 ;;

#let a = Array.make 5 3 ;;
val a : int array = [|3; 3; 3; 3; 3|] 

in questo modo genero un array con 5 elementi uguali a zero
```

### MATRIX
è possibile anche concatenare

### RECORDS

```
type person = {name: string; mutable age: int} ;;

val p:person = {name = "Mario"; age=20} ;;
```

### Aliasing
- permette di fare un aliasing di un tipo già esistente
  ```
  # type int_pair = int*int;;
  type int_pair = int * int
  # let a : int_pair = (1,3);;
  val a : int_pair = (1, 3)
  # fst a;;
  - : int = 1
  ```
- ogni tipo può essere aliasato

### Varianti
- un tipo variante, mostra tutte le possibili forme per un valore di quel tipo

  ```
  # type int_option = Nothing | AnInteger of int ;;
  type int_option = Nothing | AnInteger of` int
  # Nothing;;
  - : int_option = Nothing
  # AnInteger 7;;
  - : int_option = AnInteger 7

  ```
- Ovviamente Nothing e AnInteger sono dei costruttori
- Posso anche creare dei tipi in modo ricorsivo:

```                
type card = Card of regular | Joker
        and regular = { suit : card_suit; name : card_name; }
        and card_suit = Heart | Club | Spade | Diamond
        and card_name = Ace | King | Queen | Jack | Simple of int;;


let value = function
        Joker -> 0
        | Card {name = Ace} -> 11
        | Card {name = King} -> 10
        | Card {name = Queen} -> 9
        | Card {name = Jack} -> 8
        | Card {name = Simple n} -> n ;;

(*TESTING*)

let jack:card = Card {suit = Heart; name = Jack} ;;
let cardTest:card = Joker ;;
let jokerVal = value cardTest ;;
let jackVal = value jack ;;

print_int jokerVal ;;
print_string "\n" ;;
print_int jackVal ;;
print_string "\n" ;;

```


- questo codice permette di definire 4 tipi:
    1. card
    2. regular
    3. card_suit
    4. card_name

### Utilizzare i tipi
per poter utilizzare un tipo bisogna fare

```
let nome:tipo = costruttore ;;
```


## OCAML MODULES
- i moduli di ocaml sono dei tipi di dato
- permettono di esprimere un datatype astratto e concreto
- utilizzati per realizzare tipi di dato e insiemi di funzioni
- i moduli sono composti da due parti:
    1. (opzionale) Interfaccia pubblica che mostra il tipo e le operazioni definite nel modulo (**sig .. .end**)
    2. l'implementazione del modulo (**struct ... end**)

```
module A:
    sig
        ...
    end =
    struct
        ...
    end ;;
```
- vanno messe in file diversi! Ovviamente per una questione di implementazione

#### Esempio

```
module type BlackjackDeck = sig
        type card = Card of regular | Joker
        and regular = { suit : card_suit; name : card_name }
        and card_suit = Heart | Club | Spade | Diamond
        and card_name = Ace | King | Queen | Jack | Simple of int

        val value : card -> int
end

module BJD : BlackjackDeck = struct
        type card = Card of regular | Joker
        and regular = { suit : card_suit; name : card_name }
        and card_suit = Heart | Club | Spade | Diamond
        and card_name = Ace | King | Queen | Jack | Simple of int

        let value = function
        | Joker -> 0
        | Card { name = Ace } -> 11
        | Card { name = King } -> 10
        | Card { name = Queen } -> 9
        | Card { name = Jack } -> 8
        | Card { name = Simple n } -> n
end

let () =
        let open BJD in
        let joker = Joker in
        let qha = Card { suit = Heart; name = Queen } in
        let _ = print_int (value joker) in
        let _ = print_newline () in
        let _ = print_int (value qha) in
        print_newline ();

```

- bisogna stare attenti alla struttura del modulo: alcuni elementi non devono essere esposti, come la rappresentazione o alcune funzioni di supporto.



### COMPILAZIONE MODULI
- Mettiamo di avere due file
  1. interface.mli
  2. file.ml
- per compilare devo inserire entrambi i file nel comando:
```
ocamlc -o output interface.mli file.ml
```
```
ocamlc -c file.mli (File di interfaccia)
ocamlc -c implementation.ml (File di implementazione)
```

## FUNCTORS
> Functors are «functions» from structures to structures
- permettono di nascondere i dettagli implementativi, che possono cambiare senza influenzare chi li utilizza.
- Utili per non ripeter codice 
- struttura TYPE safe
- 
- funzione tra tipi di dati astratto
- funzione da struttura a struttura
- scrivere tipi di dato generalizzati sui tipi di dato
- servono ad evitare duplicazioni


... mancano dei pezzi ... 

## Roba figa con Fun
### Currying
-tecnica che permette di trasformare una funzione con diversi argomenti in una catena di funzioni ognuna con un unico argomento
- partial evaluation

### MAP FILTER REDUCE
- tre pattern molto importanti
#### MAP
#### FILTER
- filtra dei dati
- il filtro è una proprietà, sono dei dati

#### REDUCE
- deve aggregare, quindi ho x elmenti e li trasforma per ottenerne solo uno
- esempio, dato una lista di interi voglio sommarli tutti e ottenere la somma.


# LINGUAGGIO 2: ERLANG
## introduzione
- Erlang is a functional programming language and runtime environment. 
- It was built in such a way that it had inherent support for concurrency, distribution and fault tolerance. Erlang was originally developed to be used in several large telecommunication systems.
- But it has now slowly made its foray into diverse sectors like ecommerce, computer telephony and banking sectors as well.

## Basic Syntax
```
% hello world program
-module(helloworld). 
-export([start/0]). 

start() -> 
   io:fwrite("Hello, world!\n").

```
- questo codice è il classico hello world, ma introduce già alcuni elementi del linguaggio:
  - **%** permette di  aggiungere commenti al programma
  - **module** permette di definire il namespace delle funzioni che definiamo nel programma
  - **export** ci permette di definire che possiamo utilizzare tutte le funzoni presenti. In questo caso definiamo start e per utilizzarla dobbiamo per forza utilizzare export. lo /0 ci dice che la funzione non ha alcun parametro
  - **io:fwrite** serve per output

### Running ERLANG code
- per poter runnare il codice ERLANG dobbiamo
  1. avviare la shell tramite comando **erl**
  2. compilare il sorgente: **c(file).** file non deve avere estensione!
  3. per chiamare una funzione dopo averlo compilato: **modulo:funzione(params).**
## Tipi di dato:
### NUMERO
- Ci sono due tipi di numeri: Interi e float
```
-module(helloworld).
-export([start/0]).

start() ->
   io:fwrite("~w",[1+1]).
```
- posso accedere al valore del singolo carattere tramite <code>$char</code>

- possibile anche memorizzare un valore in una determinata base tramite <code>base#value.</code>

- per un valore float base che lo dichiaro con la dot notation, le operazioni sono normali a differenza di ocaml che richiedevano un punto dopo l'operatore

```
1> 42.
42

2> -1_234_567_890.
-1234567890

3> $A.
65

4> $\n.
10

5> 2#101.
5

6> 16#1f.
31

7> 16#4865_316F_774F_6C64.
5216630098191412324

8> 2.3.
2.3

9> 2.3e3.
2.3e3

10> 2.3e-3.
0.0023

11> 1_234.333_333
1234.333333

```
- When working with floats you may not see what you expect when printing or doing arithmetic operations. This is because floats are represented by a fixed number of bits in a base-2 system while printed floats are represented with a base-10 system. Erlang uses 64-bit floats. Here are examples of this phenomenon:

```
> 0.1+0.2.
0.30000000000000004
```

### ATOM
- una costante literal con nome maiuscolo. Deve essere chiuso tra singoli apici (') se contiene lettere minuscole o altri caratteri che non siano alfanumerici
- E’ una label , non è associato a un valore numerico , come un enum , sono stringhe senza apici che iniziano con la lettera minuscola.

- Gli atomi serviranno per la costruzione di messaggi , fungeranno da etichetta su cui verrà fatto pattern matching.
```
hello
phone_number
'Monday'
'phone number'
```


### BOOLEAN
- poco da dire, true o false


### BIT STRING
- dati senza tipo
- Bit strings that consist of a number of bits that are evenly divisible by eight, are called binaries
  
```
1> <<10,20>>.
<<10,20>>

2> <<"ABC">>.
<<"ABC">>

1> <<1:1,0:1>>.
<<2:2>>
```
### TUPLE

- sono composte da elementi
- a quanto pare sono eterogenee e quindi posso fare una roba del genere

```
1> P = {adam,24,{july,29}}.
{adam,24,{july,29}}

2> element(1,P).
adam

3> element(3,P).
{july,29}

4> P2 = setelement(2,P,25).
{adam,25,{july,29}}

5> tuple_size(P).
3

6> tuple_size({}).
0
```
### MAP
- permette di mappare roba
- funziona tramite chiavi e valori, molto utile

```
-module(helloworld). 
-export([start/0]). 

start() -> 
   M1 = #{name=>john,age=>25}, 
   io:fwrite("~w",[map_size(M1)]).
```
- Esempi di utilizzo:

```
1> M1 = #{name=>adam,age=>24,date=>{july,29}}.
#{age => 24,date => {july,29},name => adam}

2> maps:get(name,M1).
adam

3> maps:get(date,M1).
{july,29}

4> M2 = maps:update(age,25,M1).
#{age => 25,date => {july,29},name => adam}

5> map_size(M).
3

6> map_size(#{}).
0
```

## Elementi fondamentali
### Binding e Pattern Matching
- non esiste assegnamento ma solo etichette
- Variables are bound to values through the pattern matching mechanism.
- In a pattern matching, a left-hand side pattern is matched against a right-hand side term. If the matching succeeds, any unbound variables in the pattern become bound.
```
1> [B|L] = [a,b,c] %il primo elemento è abbinato a B , il resto a L
[a,b,c]

2> {A,B,L}
{1,a,[b,c]}

3> {X,X} = {B,B} %esiste un match e quindi X diventa a
{a,a}

4> {Y,Y} = {X,b} %non funziona peche X è associato ad A , e non esiste un altro X che vale b
  
```
- altro esempio
```
1> X.
** 1:1: variable 'X' is unbound **

2> X = 2.
2

3> X + 1.
3

4> {X, Y} = {1, 2}.
** exception error: no match of right hand side value {1,2}

5> {X, Y} = {2, 3}.
{2,3}

6> Y.
3

```
### Guardie
- le guardie in erlang sono stronze: sono accettate solo alcune funzioni, le BIF.
- funzioni custom non vanno bene e ci restitusice un errore

### operazioni matematiche
#### Modulo
- per fare il modulo si utilizza il REM ( reminder ):
```
N rem C
```
#### Divisioni
- le divisioni possono essere
    1. Float -> utilizzando operatore slash <code>/</code>
    2. Int -> utilizzando operatore <code>div</div>