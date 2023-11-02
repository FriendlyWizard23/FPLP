let rand_select list range =
        let stringa_random list = Random.self_init() ; List.nth list (Random.int (List.length list))
        in
        let rec estrai newlist count =
                match (count) with
                | count when count > 0 -> estrai ((stringa_random list)::newlist) (count-1)
                | _ -> newlist
       
	in estrai [] range
;;

let prova = ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"];;

rand_select prova 3;;
