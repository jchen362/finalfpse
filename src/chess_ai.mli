open Core

module type Evaluation = sig
  val pawn_score : float array array
  val knight_score : float array array
  val rook_score : float array array
  val queen_score : float array array
  val king_score : float array array
  val bishop_score : float array array

  (* returns a score for passed board state and player color*)
  val evaluate : Board.Board_state.t -> Lib.color -> float
end

module Eval : Evaluation

module type Minimax = sig
  include Evaluation

  (* 3 levels of difficulty, each definining depth for minimax. The map contains difficulty to depth mapping
    1 -> depth = 2, 2 -> depth 3, 3 -> depth 4*)
  module Difficulty_map : Map.S

  (* generates the next move based on the difficulty provided from the given FEN string.
    It returns the FEN string after performing the best move (if any) otherwise it returns the
    same FEN string back (does the same in case of any invalid input) *)
  val generate_next_move : string -> char -> int -> string
end

module Minimax : Minimax
