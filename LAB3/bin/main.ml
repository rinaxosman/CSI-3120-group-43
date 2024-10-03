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

(* the functions below are not yet implemented *)

(* Custom function to split a list at a given index *)
let rec split_at n lst =
  (* to do *)
  failwith "Not implemented"

(* Function to assign locations to vehicles based on capacity *)
let rec assign_locations_to_vehicles locations vehicles =
  (* to do *)
  failwith "Not implemented"

(* Function to calculate the total distance of a vehicle's route *)
let calculate_route_distance locations return_to_start =
  (* to do *)
  failwith "Not implemented"

(* Function to display the optimized routes for each vehicle *)
let display_routes vehicle_routes return_to_start =
  (* to do *)
  failwith "Not implemented"

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
