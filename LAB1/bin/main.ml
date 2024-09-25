(* 
   CSI 3120: LAB 1 - Group 43
   - Alex Clements (300237898)
   - Rina Osman (300222206)
   - Sameed Jafri (300253861)
*)

print_endline "Lab 1 - Group 43";

(* map2: (int -> int -> int) -> int list -> int list -> int list *)
let rec map2 f lst1 lst2 = 
  match (lst1, lst2) with
  | ([], []) -> []
  | (_::_, []) | ([], _::_) -> failwith "Lists must be of equal length"
  | (x::xs, y::ys) -> (f x y) :: (map2 f xs ys)
  in print_endline "";

(* Q1: map2 Tests *)

  print_endline "Q1 Tests (map2)";
  print_endline "";

  (* Test 1 - fun x y -> x + y *)
  let result_map2 = map2 (fun x y -> x + y) [1; 2; 3] [4; 5; 6] in
  print_endline "Test 1 - fun x y -> x + y";
  print_endline "Input: [1; 2; 3], [4; 5; 6]";
  Printf.printf "Output: [%s]\n" (String.concat "; " (List.map string_of_int result_map2));
  print_endline "";

  (* Test 2 - fun x y -> x * y *)
  let result_map2_test2 = map2 (fun x y -> x * y) [2; 4; 6] [1; 3; 5] in
  print_endline "Test 2 - fun x y -> x * y";
  print_endline "Input: [2; 4; 6], [1; 3; 5]";
  Printf.printf "Output: [%s]\n" (String.concat "; " (List.map string_of_int result_map2_test2));
  print_endline "";

  (* Test 3 - fun x y -> x - y *)
  let result_map2_test3 = map2 (fun x y -> x - y) [10; 20; 30] [5; 10; 15] in
  print_endline "Test 3 - fun x y -> x - y";
  print_endline "Input: [10; 20; 30], [5; 10; 15]";
  Printf.printf "Output: [%s]\n" (String.concat "; " (List.map string_of_int result_map2_test3));
  print_endline "";

(* Q2: filter_even Tests *)

(* filter_even: int list -> int list *)
let rec filter_even lst =
  match lst with
  | [] -> []
  | x::xs -> if x mod 2 = 0 then x :: filter_even xs else filter_even xs
  

(* Q2: filter_even Tests *)
  in print_endline "Q2 Tests (filter_even)";
  print_endline "";

  (* Test 1 *)
  let result_filter_even = filter_even [1; 2; 3; 4; 5; 6] in
  print_endline "Test 1";
  print_endline "Input: [1; 2; 3; 4; 5; 6]";
  Printf.printf "Output: [%s]\n" (String.concat "; " (List.map string_of_int result_filter_even));
  print_endline "";

  (* Test 2 *)
  let result_filter_even_test2 = filter_even [10; 15; 20; 25; 30] in
  print_endline "Test 2";
  print_endline "Input: [10; 15; 20; 25; 30]";
  Printf.printf "Output: [%s]\n" (String.concat "; " (List.map string_of_int result_filter_even_test2));
  print_endline "";

  (* Test 3 *)
  let result_filter_even_test3 = filter_even [7; 14; 21; 28; 35; 42] in
  print_endline "Test 3";
  print_endline "Input: [7; 14; 21; 28; 35; 42]";
  Printf.printf "Output: [%s]\n" (String.concat "; " (List.map string_of_int result_filter_even_test3));
  print_endline "";


(* compose_functions: ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c *)
let compose_functions f g =
  fun x -> f (g x)

(* Q3: compose_functions Tests *)

  in print_endline "Q3 Tests (compose_functions)";
  print_endline "";
  (* Test 1 *)
  let composed = compose_functions (fun x -> x * 2) (fun y -> y + 3) in
  let result_composed = composed 5 in
  print_endline "Test 1 - fun x -> x * 2, fun y -> y + 3";
  print_endline "Input: 5";
  Printf.printf "Output: %d\n" result_composed;
  print_endline "";

  (* Test 2 *)
  let composed_test2 = compose_functions (fun x -> x - 1) (fun y -> y * 3) in
  let result_composed_test2 = composed_test2 4 in
  print_endline "Test 2 - fun x -> x - 1, fun y -> y * 3";
  print_endline "Input: 4";
  Printf.printf "Output: %d\n" result_composed_test2;

  print_endline "";
  (* Test 3 *)
  let composed_test3 = compose_functions (fun x -> x / 2) (fun y -> y + 10) in
  let result_composed_test3 = composed_test3 8 in
  print_endline "Test 3 - fun x -> x / 2, fun y -> y + 10";
  print_endline "Input: 8";
  Printf.printf "Output: %d\n" result_composed_test3;
  print_endline "";


(* reduce: ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
let rec reduce f acc lst = 
  match lst with
  | x::xs -> reduce f (f acc x) xs
  | [] -> acc

(* Q4: reduce Tests *)

  in print_endline "Q4 Tests (reduce)";
  print_endline "";

  (* Test 1 *)
  let result_reduce = reduce (fun x y -> x + y) 0 [1; 2; 3; 4] in
  print_endline "Test 1 - (fun x y -> x + y) acc = 0";
  print_endline "Input: [1; 2; 3; 4]";
  Printf.printf "Output: %d\n" result_reduce;
  print_endline "";

  (* Test 2 *)
  let result_reduce_test2 = reduce (fun x y -> x * y) 1 [2; 3; 4; 5] in
  print_endline "Test 2 - (fun x y -> x * y) acc = 1";
  print_endline "Input: [2; 3; 4; 5]";
  Printf.printf "Output: %d\n" result_reduce_test2;
  print_endline "";

  (* Test 3 *)
  let result_reduce_test3 = reduce (fun x y -> x - y) 10 [1; 2; 3] in
  print_endline "Test 3 - (fun x y -> x - y) acc = 10";
  print_endline "Input: [1; 2; 3]";
  Printf.printf "Output: %d\n" result_reduce_test3;
