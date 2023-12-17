(* open Core

(* POST: from a FEN board state and difficulty, return a set of possible moves *)
val get_suggested_moves : Dream.request -> Dream.response Lwt.t

(* POST: from a FEN board state and move (e.g. Ke1), return the evaluation for that move *)
val get_move_evaluation : Dream.request -> Dream.response Lwt.t *)
