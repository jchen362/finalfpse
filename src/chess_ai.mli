open Core
open Lib

module type Evaluation = sig
  val pawn_score : float array array
  val knight_score : float array array
  val rook_score : float array array
  val queen_score : float array array
  val king_score : float array array
  val bishop_score : float array array

  (* returns a score for passed board state*)
  val evaluate : (board : Board_State.t) (player_color : color) -> int
end

module type Minimax = sig
  Include Evaluation

  type alpha_beta = {alpha : float; beta : float}

  (* likely 5 levels of difficulty, each level has static alpha beta values to be used 
  for pruning which essentially decides the depth of the search tree *)
  val difficulty_map : alpha_beta Map.Make(Int)

  (* generates the next move based on the difficulty provided *)
  val generate_next_move : (board_str : string) -> (difficulty : int) -> string

end