# Lezione 1 intro
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
## OcaML
- ML è un acronimo di MetaLanguage, è una astrazione del delta-calculus polimorfo
- ha una serie di caratteristiche:
    - **eager evaluation** = Tutte le sub-expressions sono sempre evaluated. è possibile anche effettuare "Lazy Evaluation"
    - **Call by vaue** evaulation strategy
    -**First class functions**
    -Molto altro
- OCaML viene installato con
    - un interprete (ocaml)
    - un compilatore (ocamlc)
### Elementi di programmazione
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

### Pattern matching
- le espressioni possono essere definite da patern matching
- i pattern possono contenere costanti, tuple, records,costruttori varianti e nomi varianti
Quando un pattern viene matchato:
- la expression corrispondente viene restituita
- la clause "when" opzionale, è una guardia del sistema di matching, filtra match non desiderati
- Esempio:
```
let invert x =
    match x with 
    | true -> false
    | false -> true ;;

let invert' = function
    true -> false | false -> true ;;
```