(* 
   CSI 3120: LAB 1 - Group 43
   - Alex Clements ()
   - Rina Osman (300222206)
   - Sameed Jafri ()
*)

print_endline "Lab 1 - Group 43";

(* map2: (int -> int -> int) -> int list -> int list -> int list *)
  let rec map2 f lst1 lst2 = 
    match (lst1, lst2) with
    | ([], []) -> []
    | (_::_, []) | ([], _::_) -> failwith "Lists must be of equal length"
    | (x::xs, y::ys) -> (f x y) :: (map2 f xs ys)
  in
  let result_map2 = map2 (fun x y -> x + y) [1; 2; 3] [4; 5; 6] in
  Printf.printf "Q1) map2 result: [%s]\n" (String.concat "; " (List.map string_of_int result_map2));

(* filter_even: int list -> int list *)
  let rec filter_even lst =
    match lst with
    | [] -> []
    | x::xs -> if x mod 2 = 0 then x :: filter_even xs else filter_even xs
  in
  let result_filter_even = filter_even [1; 2; 3; 4; 5; 6] in
  Printf.printf "Q2) filter_even result: [%s]\n" (String.concat "; " (List.map string_of_int result_filter_even));

(* compose_functions: ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c *)
  let compose_functions f g =
    fun x -> f (g x)
  in
  let composed = compose_functions (fun x -> x * 2) (fun y -> y + 3) in
  let result_composed = composed 5 in
  Printf.printf "Q3) composed result: %d\n" result_composed;

(* reduce: ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
  let rec reduce f acc lst = 
    match lst with
    | [] -> acc
    | x::xs -> reduce f (f acc x) xs
  in
  let result_reduce = reduce (fun x y -> x + y) 0 [1; 2; 3; 4] in
  Printf.printf "Q4) reduce result: %d\n" result_reduce;
