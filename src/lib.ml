open Core

type color = Black | White
type position_key = { x : int; y : int } [@@deriving compare, sexp]

module type Piece = sig
  val in_bounds : position_key -> bool

  (* sees if you can move a piece from start to end position DOES NOT ACCOUNT FOR ACTUAL BOARD STATE *)
  val can_move : position_key -> position_key -> bool

  (* generates move for a piece based on possible positions DOES NOT ACCOUNT FOR THE ACTUAL BOARD STATE *)
  val generate_moves : position_key -> color -> position_key list
end