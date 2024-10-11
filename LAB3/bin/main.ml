(* 
   CSI 3120: LAB 3 - Group 43
   - Alex Clements (300237898)
   - Rina Osman (300222206)
   - Sameed Jafri (300253861)
*)

(* ChatGPT along with GitHub Copilot was used in the creation of this solution *)

(* Helper function to read a float input from the user *)
let read_float prompt =
  Printf.printf "%s" prompt;
  flush stdout;
  float_of_string (input_line stdin)

(* Helper function to read an integer input from the user *)
let read_int prompt =
  Printf.printf "%s" prompt;
  flush stdout;
  int_of_string (input_line stdin)

(* Helper function to read a string input from the user *)
let read_string prompt =
  Printf.printf "%s" prompt;
  flush stdout;
  input_line stdin

(* Type definition for a delivery location *)
type location = {
  name : string;
  x : float;  (* Updated to float *)
  y : float;  (* Updated to float *)
  priority : int;
}

(* Type definition for a vehicle *)
type vehicle = {
  id : int;
  capacity : int;
}

(* Function to read the details of a location *)
let read_location n =
  Printf.printf "Enter details for location %d:\n" n;
  let name = read_string "Location Name: " in
  let x = read_float "X Coordinate: " in
  let y = read_float "Y Coordinate: " in
  let priority = read_int "Priority: " in
  {name; x; y; priority }

(* Function to read the details of a vehicle *)
let read_vehicle n =
  Printf.printf "Enter details for vehicle %d:\n" n;
  let capacity = read_int "Capacity: " in
  {id = n; capacity }

(* Function to sort locations by priority *)
let sort_locations_by_priority locations =
  List.sort (fun l1 l2 -> compare l2.priority l1.priority) locations

(* Function to calculate the Euclidean distance between two locations *)
let distance loco1 loco2 =
  let dx = loco2.x -. loco1.x in
  let dy = loco2.y -. loco1.y in
  sqrt (dx *. dx +. dy *. dy)

(* Custom function to split a list at a given index *)
let rec split_at n lst =
  if n <= 0 then ([], lst)
  else match lst with
    | [] -> ([], [])
    | h :: t ->
      (* left is the list of elements before the split point, and right is the list of elements after the split point *)
      let (left, right) = split_at (n - 1) t in
      (* prepend the head element to the left list and return the tuple *)
      (h :: left, right)

(* Function to assign locations to vehicles based on capacity *)
let assign_locations_to_vehicles locations vehicles =
  (* helper function aux to process the lists of locations and vehicles *)
  let rec aux locations vehicles acc =
    match vehicles with
    | [] -> acc
    | v :: vs ->
      (* splitting the locations list at the vehicles capacity *)
      let (assigned, remaining) = split_at v.capacity locations in
      (* appendding the assigned locations of the vehicle to the accumulator and calling aux recursively with the remaining locations and vehicles *)
      aux remaining vs ((v, assigned) :: acc)
  in
  (* calling aux with the initial lists of locations and vehicles and an empty accumulator *)
  aux locations vehicles []

(* Function to calculate the total distance of a vehicle's route *)
let calculate_route_distance locations return_to_start =
  (* helper function to perfrom the distance calculation *)
  let rec aux locos acc =
    match locos with
    | [] | [_] -> acc
    | loco1 :: (loco2 :: _ as rest) -> aux rest (acc +. distance loco1 loco2) in
  let total_distance = aux locations 0.0 in
  if return_to_start then
    match locations with
    | [] -> 0.0
    | first :: _ -> total_distance +. distance (List.hd (List.rev locations)) first (* calculating distance from last location to first *)
  else
    total_distance

(* Function to display the optimized routes for each vehicle *)
let display_routes vehicle_routes return_to_start =
  (* iterate through routes for each vehicle and print the details *)
  List.iter (fun (vehicle, route) -> 
    Printf.printf "Vehicle %d with capacity %d:\n" vehicle.id vehicle.capacity;
    List.iter (fun location -> Printf.printf "%s (Priority: %d)\n" location.name location.priority) route;
    let total_distance = calculate_route_distance route return_to_start in
    Printf.printf "Total Distance: %.2f\n" total_distance
  ) vehicle_routes


(* Main function to gather inputs, optimize routes, and display results *)
let main () =
  (* Get the number of locations and vehicles *)
  let num_locations = read_int "How many delivery locations? " in
  let locations = List.init num_locations (fun i -> read_location (i + 1)) in
  
  let num_vehicles = read_int "How many vehicles? " in
  let vehicles = List.init num_vehicles (fun i -> read_vehicle (i + 1)) in

  (* Sort locations by priority *)
  let sorted_locations = sort_locations_by_priority locations in

  (* Assign locations to vehicles *)
  let vehicle_routes = assign_locations_to_vehicles sorted_locations vehicles in

  (* Ask if vehicles should return to the start *)
  let return_to_start = read_int "Should vehicles return to starting location? (1 for yes, 0 for no): " = 1 in

  (* Display optimized routes*)
  display_routes vehicle_routes return_to_start

let () = main ()
