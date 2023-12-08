open Core
open Lib

[@@@ocaml.warning "-27"]

module type Evaluation = sig
  val pawn_score : float array array
  val knight_score : float array array
  val rook_score : float array array
  val queen_score : float array array
  val king_score : float array array
  val bishop_score : float array array

  (* returns a score for passed board state*)
  val evaluate : Board.Board_state.t -> color -> int
end

module Eval : Evaluation = struct
  let pawn_score = [| [| 0.0 |] |] 
  let knight_score = [| [| 0.0 |] |] 
  let rook_score = [| [| 0.0 |] |] 
  let queen_score = [| [| 0.0 |] |] 
  let king_score = [| [| 0.0 |] |] 
  let bishop_score = [| [| 0.0 |] |] 

  let evaluate b c = match b, c with 
    | a, b -> 10
  
end

module type Minimax = sig
  include Evaluation

  type alpha_beta = { alpha : float; beta : float }

  (* likely 5 levels of difficulty, each level has static alpha beta values to be used
     for pruning which essentially decides the depth of the search tree *)
  (* module Difficulty_map : Map.Make(Int); value is alpha_beta *)
  module Difficulty_map : Map.S

  (* generates the next move based on the difficulty provided *)
  val generate_next_move : string -> int -> string
end
