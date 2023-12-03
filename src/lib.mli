(* open Core *)

type color = Black | White
type position_key = { x : int; y : int } [@@deriving compare, sexp]

(* NOTE: PAWN CAN BECOME QUEEN *)

module type Piece = sig
  val in_bounds : position_key -> bool

  (* sees if you can move a piece from start to end position DOES NOT ACCOUNT FOR ACTUAL BOARD STATE *)
  val can_move : position_key -> position_key -> color -> bool

  (* generates move for a piece based on possible positions DOES NOT ACCOUNT FOR THE ACTUAL BOARD STATE *)
  val generate_moves : position_key -> color -> position_key list
end

module Tree : sig
  type 'a t = Leaf | Branch of { item : 'a t; nodes : 'a t list }
end


module Make_piece (_ : Piece) : Piece
(* check in board state whether or not it is promoted and change the piece accordingly *)
module Pawn : Piece (*Sana*)
module Rook : Piece (*Sana*)
module King : Piece (*Jianwei*)
module Queen : Piece (*Jianwei*)
module Bishop : Piece (*Brandon*)
module Knight : Piece (*Brandom*)

