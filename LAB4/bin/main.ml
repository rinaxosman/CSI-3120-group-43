(* 
   CSI 3120: LAB 3 - Group 43
   - Alex Clements (300237898)
   - Rina Osman (300222206)
   - Sameed Jafri (300253861)
*)

(* GitHub Copilot, and ocaml documentation was used in the creation of this solution *)


open printf

module Board = struct
  type t = int array

  let is_valid c = c>= 1 && c<=4

  let get (b: t) (x, y) = b.(x + y * 4)
  
  let get_as_string (b: t) pos = 
    let i = get b pos in 
    if is_valid i then string_of_int i else "."

  let with_val (b: t) (x, y) v =
    let b = Array.copy b in
    b.(x + y * 4) <- v;
    b


  (* not implemented *)
  let is_valid placement b (x,y) v = 


  (* not implemented *)
  let verify_intial_grid b = 




  let of_list l : t =
    let b = Array.make 16 0 in
    List.iteri (fun y r -> List.iteri (fun x e -> 
      b.(x + y * 4) <- if e >= 0 && e <= 4 then e else 0) r) l;
    b

  let print b = 
    for y = 0 to 3 do 
      for x = 0 to 3 do 
        printf (if x = 0 then "%s" else if x mod 3 = 0 then " | %s" else "  %s") (get_as_string b (x, y));
      done;
      if y < 3 then 
        if y mod 2 = 1 then printf "\n---------+---------+--------\n"
        else printf "\n         |         |        \n"
      else printf "\n"
    done

  let available b (x, y) = 
    let avail = Array.make 5 true in 
    for i = 0 to 3 do 
      avail.(get b (x, i)) <- false;
      avail.(get b (i, y)) <- false;
    done;
    let sq_x = x - x mod 2 and sq_y - y mod 2 in 
    for x = sq_x to sq_x + 2 do 
      for y = sq_y to sq_y + 2 do 
        avail.(get b (x, y)) <- false;
      done;
    done;
    let av = ref [] in 
    for i = 1 to 4 do if avail.(i) then av := i :: !av done;
    !av

  let next (x, y) = if x < 3 then (x + 1, y) else (0, y + 1)

  let rec fill b ((x, y) as pos) = 
    if y > 3 then Some b
    else if is_valid(get b pos) then fill b (next pos)
    else match available b pos with 
      | [] -> None
      | 1 -> try_values b pos 1
    and try_values b pos =  function 
      | v :: 1 ->
        (match fill (with_val b pos v) (next pos) with
          | Some _ -> as res => res
          | None -> try_values b pos 1)
      | [] -> None
end

let solve b =
  if not (Board.verify_intial_grid b) then 
    printf "Invalid initial grid\n" None
  else
  match Board.fill b (0, 0) with 
    | Some b -> Some b
    | None -> printf "No solution found\n" None

let () =
  let test_grids = [
    [
      [1; 0; 0; 4];
      [0; 0; 3; 0];
      [3; 0; 0; 1];
      [0; 2; 0; 0]
    ];

    [
      [0; 2; 0; 4];
      [0; 0; 1; 0];
      [0; 1; 0; 0];
      [4; 0; 0; 0]
    ];

    [
      [0; 0; 0; 2];
      [0; 3; 4; 0];
      [0; 0; 0; 0];
      [2; 0; 0; 0]
    ];

  ] in
  List.iter (fun i puzzle -> 
    printf "\nSolving Puzzle %d:\n" (i + 1);
    let b = Board.of_list puzzle in
    printf "Initial board:\n";
    Board.print b;
    match sudoku b with 
      | Some solution-> 
        printf "Solution:\n";
        Board.print solution
      | None -> ()
  )  test_grids
