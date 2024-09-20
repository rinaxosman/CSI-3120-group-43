let () = print_endline "Hello, World!"

(* map2: (int -> int -> int) -> int list -> int list -> int list *)
let rec map2 f lst1 lst2 = 
  match (lst1, lst2) with
  | ([], []) -> []
  | (_::_, []) | ([], _::_) -> failwith "Lists must be of equal length"
  | (x::xs, y::ys) -> (f x y) :: (map2 f xs ys);;

map2 (fun x y -> x + y) [1; 2; 3] [4; 5; 6];;

(* filter_even: int list -> int list *)
let rec filter_even lst =
  match lst with
  | [] -> []
  | x::xs -> if x mod 2 = 0 then x :: filter_even xs else filter_even xs;;

  filter_even [1; 2; 3; 4; 5; 6];;

(* compose_functions: ('b -> 'c) -> ('a -> 'b) -> 'a -> 'c *)
let compose_functions f g =
  fun x -> f (g x);;

let composed = compose_functions (fun x -> x * 2) (fun y -> y + 3);;
composed 5;;

(* reduce: ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
let rec reduce f acc lst = 
  match lst with
  | [] -> acc
  | x::xs -> reduce f (f acc x) xs;;

reduce (fun x y -> x + y) 0 [1; 2; 3; 4];;