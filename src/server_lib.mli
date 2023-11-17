(* open Core *)

(* GET: from a FEN board state, return a set of possible moves *)
val get_suggested_moves : Dream.request -> Dream.response

(* GET: from a move (e.g. Ke1), return the evaluation for that move *)
val get_move_evaluation : Dream.request -> Dream.response
