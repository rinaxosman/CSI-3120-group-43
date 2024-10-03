(* 
   CSI 3120: LAB 3 - Group 43
   - Alex Clements (300237898)
   - Rina Osman (300222206)
   - Sameed Jafri (300253861)
*)

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
  let x = read_float "X Coordinate: " in  (* Now reads float *)
  let y = read_float "Y Coordinate: " in  (* Now reads float *)
  let priority = read_int "Priority: " in
  { name; x; y; priority }

(* Function to read the details of a vehicle *)
let read_vehicle n =
  Printf.printf "Enter details for vehicle %d:\n" n;
  let capacity = read_int "Capacity: " in
  { id = n; capacity }

(* Custom function to split a list at a given index *)
let rec split_at n lst =
  if n <= 0 then ([], lst)
  else match lst with
    | [] -> ([], [])
    | x :: xs ->
        let (left, right) = split_at (n - 1) xs in
        (x :: left, right)

(* Function to sort locations by priority *)
let sort_locations_by_priority locations =
  List.sort (fun l1 l2 -> compare l2.priority l1.priority) locations

(* Function to assign locations to vehicles based on capacity *)
let rec assign_locations_to_vehicles locations vehicles =
  match vehicles with
  | [] -> []
  | v :: vs ->
      let assigned, remaining = split_at v.capacity locations in
      (v, assigned) :: assign_locations_to_vehicles remaining vs

(* Function to calculate the Euclidean distance between two locations *)
let distance loc1 loc2 =
  let dx = loc2.x -. loc1.x in
  let dy = loc2.y -. loc1.y in
  sqrt (dx *. dx +. dy *. dy)

(* Function to calculate the total distance of a vehicle's route *)
let calculate_route_distance locations return_to_start =
  match locations with
  | [] -> 0.0
  | first :: rest ->
      let rec aux prev_loc locs total_dist =
        match locs with
        | [] -> total_dist
        | loc :: ls ->
            let dist = distance prev_loc loc in
            aux loc ls (total_dist +. dist)
      in
      let total_dist = aux first rest 0.0 in
      if return_to_start then total_dist +. distance (List.hd locations) first
      else total_dist

(* Function to display the optimized routes for each vehicle *)
let display_routes vehicle_routes return_to_start =
  List.iter (fun (v, route) ->
    Printf.printf "\nVehicle %d Route:\n" v.id;
    List.iter (fun loc -> Printf.printf "  - %s\n" loc.name) route;
    let total_distance = calculate_route_distance route return_to_start in
    Printf.printf "Total Distance: %.2f\n" total_distance;
  ) vehicle_routes

(* Main function to gather inputs, optimize routes, and display results *)
let main () =
  (* Step 1: Get the number of locations and vehicles *)
  let num_locations = read_int "How many delivery locations? " in
  let locations = List.init num_locations (fun i -> read_location (i + 1)) in
  
  let num_vehicles = read_int "How many vehicles? " in
  let vehicles = List.init num_vehicles (fun i -> read_vehicle (i + 1)) in

  (* Step 2: Sort locations by priority *)
  let sorted_locations = sort_locations_by_priority locations in

  (* Step 3: Assign locations to vehicles *)
  let vehicle_routes = assign_locations_to_vehicles sorted_locations vehicles in

  (* Step 4: Ask if vehicles should return to the start *)
  let return_to_start = read_int "Should vehicles return to starting location? (1 for yes, 0 for no): " = 1 in

  (* Step 5: Display the optimized routes *)
  display_routes vehicle_routes return_to_start

(* Run the main function *)
let () = main ()
