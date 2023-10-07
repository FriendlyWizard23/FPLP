type temperature = {value:float; scale:string}
let scales = [|"Celsius";"Kelvin";"Rankie";"Delisle";"Newton";"Reaumur";"Rome"|];;

let kelvin temp = { value = (temp.value +. 273.15); scale = "Kelvin" } ;;
let rankie temp = { value = (temp.value *. 1.8 +. 491.67); scale = "Rankie" };;
let delisle temp = { value = (temp.value *. 1.5 -. 100.); scale = "Delisle" };;
let newton temp = { value = (temp.value /. 3.03); scale = "Newton" };;
let reaumur temp = { value = (temp.value /. 1.25); scale = "Reaumur" };;
let rome temp = { value = ((temp.value /. 1.90) +. 7.5); scale = "Rome" };;

let get_celsius_temperature temp =
  match temp.scale with
  	| "Celsius" -> temp
  	| "Kelvin" -> {value = (temp.value -. 273.15); scale = "Celsius" }
  	| "Rankie" -> {value = ((temp.value -. 491.67) /. 1.8); scale = "Celsius" }
  	| "Delisle" -> {value = (temp.value +. 100.) /. 1.5; scale = "Celsius" }
  	| "Newton" -> {value = (temp.value *. 3.03); scale = "Celsius" }
  	| "Reaumur" -> {value = (temp.value *. 1.25); scale = "Celsius" }
  	| "Rome" -> {value = ((temp.value -. 7.5) *. 1.90); scale = "Celsius" }
	| _ -> temp ;;

let temperature_manager temp conversion = 
	match conversion with
        | "Celsius" -> get_celsius_temperature temp
	| "Kelvin" -> kelvin (get_celsius_temperature temp)
	| "Rankie" -> rankie (get_celsius_temperature temp)
        | "Delisle" -> delisle (get_celsius_temperature temp)
        | "Newton" -> newton (get_celsius_temperature temp)
        | "Reaumur" -> reaumur (get_celsius_temperature temp)
        | "Rome" -> rome (get_celsius_temperature temp)
	| _	-> temp ;;

let convert_all temp = 
	let rec convert count newlist= 
		if count==7 then newlist
		else convert (count + 1)(List.append (newlist) ([temperature_manager temp scales.(count)]))
	in convert 0 [];;

let print_temperature temp index=
	Printf.printf "{%.2f:%s}" temp.value temp.scale;
	if (index+1) mod 7 = 0 then
    		print_string("\n\n") ;;

let print_temp_list list = 
  let rec print_list list index =
    match list with
    | [] -> ()
    | temp :: rest ->
      	print_temperature temp index;
      	print_list rest (index+1)
  in
  print_list list 0;;

let generate_table default_value scales = 
	let rec generate list index =
		if index == 7 then list
		else generate (List.append(list)(convert_all({value=default_value;scale=scales.(index)})))(index+1)
	in generate [] 0 
;;

print_temp_list (generate_table 10. scales) ;;
