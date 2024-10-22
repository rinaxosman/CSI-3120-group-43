(* 
   CSI 3120: LAB 3 - Group 43
   - Alex Clements (300237898)
   - Rina Osman (300222206)
   - Sameed Jafri (300253861)
*)

(* GitHub Copilot, and ocaml documentation was used in the creation of this solution *)

module Board = struct
  type t = int array

  let get (b: t) (x, y) = b.(x + y * 4)

  let with_val (b: t) (x, y) v =
    let b = Array.copy b in
    b.(x + y * 4) <- v;
    b

  let is_valid b (x, y) v = 
    (* Check rows *)
    let valid_row = ref true in
    for i = 0 to 3 do
      if get b (i, y) = v then valid_row := false
    done;
    if not !valid_row then false
    else
      (* Check columns *)
      let valid_column = ref true in
      for i = 0 to 3 do
        if get b (x, i) = v then valid_column := false
      done;
      if not !valid_column then false
      else
        (* Check subgrid *)
        let subgrid_x = (x / 2) * 2 in
        let subgrid_y = (y / 2) * 2 in
        let valid_subgrid = ref true in
        for i = subgrid_x to subgrid_x + 1 do
          for j = subgrid_y to subgrid_y + 1 do
            if get b (i, j) = v then valid_subgrid := false
          done;
        done;
        !valid_subgrid

  let verify_initial_grid b =
    let valid = ref true in
    for y = 0 to 3 do
      for x = 0 to 3 do
        let v = get b (x, y) in
        (* Check only if the cell is filled (v != 0) *)
        if v != 0 then (
          (* Temporarily remove the value at (x, y) *)
          let temp_b = with_val b (x, y) 0 in
          (* Check if placing the value again at (x, y) is valid *)
          if not (is_valid temp_b (x, y) v) then
            valid := false
        )
      done;
    done;
    !valid

  let of_list l : t =
    let b = Array.make 16 0 in
    List.iteri (fun y r -> List.iteri (fun x e ->
      b.(x + y * 4) <- if e >= 0 && e <= 4 then e else 0) r) l;
    b

  (* Function to print the board in clean row-by-row format *)
  let print b =
    for y = 0 to 3 do
      Printf.printf "%d, %d, %d, %d\n" (get b (0, y)) (get b (1, y)) (get b (2, y)) (get b (3, y))
    done

  let available b (x, y) =
    let avail = Array.make 5 true in
    for i = 0 to 3 do
      avail.(get b (x, i)) <- false;
      avail.(get b (i, y)) <- false;
    done;
    let sq_x = (x / 2) * 2 and sq_y = (y / 2) * 2 in
    for i = sq_x to sq_x + 1 do
      for j = sq_y to sq_y + 1 do
        avail.(get b (i, j)) <- false;
      done;
    done;
    let av = ref [] in
    for i = 1 to 4 do
      if avail.(i) then av := i :: !av done;
    !av

  let next (x, y) = if x < 3 then (x + 1, y) else (0, y + 1)

  let rec fill b pos =
    let (_, y) = pos in 
    if y > 3 then Some b
    else if get b pos != 0 then fill b (next pos)  (* Skip filled cells *)
    else match available b pos with
      | [] -> None
      | avail -> try_values b pos avail

  and try_values b pos = function
    | v :: vs -> (
        match fill (with_val b pos v) (next pos) with
        | Some solution -> Some solution
        | None -> try_values b pos vs
      )
    | [] -> None

end

let solve b =
  if not (Board.verify_initial_grid b) then (
    Format.printf "Invalid initial grid\n";
    None
  ) else
    match Board.fill b (0, 0) with
    | Some solution -> Some solution
    | None -> Format.printf ""; None

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

  List.iteri (fun i puzzle -> 
    Printf.printf "\nSolving Puzzle %d:\n\n" (i + 1);
    let b = Board.of_list puzzle in
    Printf.printf "Initial board:\n";
    Board.print b;
    match solve b with 
      | Some solution -> 
        Printf.printf "\nSolution:\n";
        Board.print solution
      | None -> Printf.printf "\nNo solution found!\n"
  ) test_grids
