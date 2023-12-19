(* open Core

let home (request : Dream.request) : Dream.response Lwt.t = 
  Dream.html (Template.default_board request)

(* GET: from a FEN board state and difficulty, return a set of possible moves *)
let get_suggested_move (request : Dream.request) : Dream.response Lwt.t = 
  (* match Dream.param request "fen", Dream.param request "difficulty" with
  | fen, difficulty ->
    Chess_ai.generate_next_move fen (int_of_string difficulty) |> (* deriving json -> Yojson -> Dream.json*)
    Dream.json
  | _ ->
    Dream.json "error" look into rescript *)
    let board = Dream.query request "board" in
    let difficulty = Dream.query request "difficulty" in
    match (board, difficulty) with
    | Some board, Some difficulty ->
        Dream.html (Template.default_board request)
    | _ -> Dream.empty `Bad_Request

(* GET: from a FEN board state and move (e.g. Ke1), return the evaluation for that move *)
let get_move_evaluation : Dream.request -> Dream.response Lwt.t =  *)
