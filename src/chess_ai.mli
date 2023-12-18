open Core

module type Evaluation = sig
  val pawn_score : float array array
  val knight_score : float array array
  val rook_score : float array array
  val queen_score : float array array
  val king_score : float array array
  val bishop_score : float array array

  (* returns a score for passed board state*)
  val evaluate : Board.Board_state.t -> float
end

module Eval : Evaluation

module type Minimax = sig
  include Evaluation

  (* likely 5 levels of difficulty, each level has static alpha beta values to be used
     for pruning which essentially decides the depth of the search tree *)
  (* module Difficulty_map : Map.Make(Int); value is alpha_beta *)
  module Difficulty_map : Map.S

  (* generates the next move based on the difficulty provided *)
  val generate_next_move : string -> char -> int -> string
end

module Minimax : Minimax
