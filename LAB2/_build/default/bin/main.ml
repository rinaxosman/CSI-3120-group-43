(* 
   CSI 3120: LAB 2 - Group 43
   - Alex Clements (300237898)
   - Rina Osman (300222206)
   - Sameed Jafri (300253861)
*)

(* Note: ChatGPT Assistance was used in the creation of this solution, particularly for the read_int function *)



(* read_int: (string) -> int *)
let rec read_int prompt =
  Printf.printf "%s" prompt;
  flush stdout;
  try
    int_of_string (input_line stdin)
  with
  | Failure _ ->
    Printf.printf "Invalid input, please enter a valid number.\n";
    read_int prompt

(* defines the "job" type *)
type job = {
  start_time : int;  
  duration : int;
  priority : int;
}

(* converts given time to minutes and adds *)
(* time_to_minutes: int + int -> int *)
let time_to_minutes hours minutes =
  (hours * 60) + minutes

(* reads user input from the terminal *)
(* read_job *)
let read_job n =
  Printf.printf "For job %d, please enter the following details:\n" n;
  let start_hours = read_int "- Start Time (hours): " in
  let start_minutes = read_int "- Start Time (minutes): " in
  let start_time = time_to_minutes start_hours start_minutes in
  let duration = read_int "- Duration (minutes): " in
  let priority = read_int "- Priority: " in
  { start_time; duration; priority }

(* function to handle reading multiple jobs from the user/terminal *)
let rec read_jobs n acc =
  if n <= 0 then acc
  else read_jobs (n - 1) (read_job n :: acc)

(* Strategy #1: No Overlaps *)
let schedule_jobs jobs =
  let sorted_jobs = List.sort (fun j1 j2 -> compare j1.start_time j2.start_time) jobs in
  let rec remove_overlaps acc = function
    | [] -> List.rev acc
    | j1 :: j2 :: rest ->
      if j1.start_time + j1.duration <= j2.start_time then
        remove_overlaps (j1 :: acc) (j2 :: rest)
      else
        remove_overlaps (j1 :: acc) rest
    | [j] -> List.rev (j :: acc)
  in remove_overlaps [] sorted_jobs

(* Strategy #2: Maximize Priority *)
let schedule_jobs_max_priority jobs =
  List.sort (fun j1 j2 -> compare j2.priority j1.priority) jobs

(* Strategy #3: Mainimizing Idle Time *)
let schedule_jobs_min_idle jobs =
  let sorted_jobs = List.sort (fun j1 j2 -> compare j1.start_time j2.start_time) jobs in
  sorted_jobs  (* Assumes jobs are already sorted to minimize idle time *)

(* Prints the scheduled jobs *)
let print_schedule jobs =
  List.iter (fun job ->
    Printf.printf "Job scheduled: Start Time = %d minutes, Duration = %d minutes, Priority = %d\n"
      job.start_time job.duration job.priority
  ) jobs

(* Main function -> Handles initial user input and runs the program *)
let main () =
  print_endline "Lab 2 - Group 43";
  let n = read_int "How many jobs do you want to schedule? " in
  let jobs = read_jobs n [] in
  let strategy = read_int "Choose a scheduling strategy (1 for No Overlaps, 2 for Max Priority, 3 for Minimize Idle Time): " in
  let scheduled_jobs = match strategy with
    | 1 -> schedule_jobs jobs
    | 2 -> schedule_jobs_max_priority jobs
    | 3 -> schedule_jobs_min_idle jobs
    | _ -> failwith "Please enter a proper strategy ID"
  in
  print_schedule scheduled_jobs

(* Entry point of the program *)
let () = main ()