let insert char num list =
        let rec ins cha pos count nlist = function
        | [] -> List.rev nlist
        | hd :: tl when count = (pos-1) -> ins cha pos (count + 1) (hd::cha:: nlist) tl
        | hd :: tl -> ins cha pos (count + 1) (hd :: nlist) tl
        in
        match num with
        | num when num > (List.length list) -> list @ [char]
        | _ -> ins char num 0 [] list

let () =
        let myList = [1; 2; 3; 4; 5; 6; 7; 8; 9] in
        let positionsToRotate = 3 in
        let character = 0 in
        let rotatedList = insert character positionsToRotate myList in
        Printf.printf "Original List: [%s]\n" (String.concat "; " (List.map string_of_int myList));
        Printf.printf "Rotated List: [%s]\n" (String.concat "; " (List.map string_of_int rotatedList))
