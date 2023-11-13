open Core

type piece_type = Pawn | Rook | Knight | Queen | King | Bishop
type color = Black | White
type position_key = { x : int; y : int } [@@deriving compare, sexp]

module Board_State : sig
  module Item_Key : Map.Key with type t = position_key

  type t

  (*creates a board state from a string*)
  val import : string -> t

  (*exports a board state into string form*)
  val export : t -> string

  (*checks if given board state is in check*)
  val in_check : t -> color -> bool

  (*checks if given board state is in checkmate*)
  val in_checkmate : t -> color -> bool

  (*checks if given board state is in stalemate*)
  val in_stalemate : t -> color -> bool

  val valid_moves_piece : t -> position_key -> position_key list

  val valid_moves_color : t -> color -> position_key list

  (*takes in board state, start and end position, returns option saying move was successfully made and board state*)
  val move : t -> position_key -> position_key -> t option
end

(*NOTE: PAWN CAN BECOME QUEEN*)

module type Piece = sig
  val in_bounds : position_key -> bool

  (*generates move for a piece based on possible positions DOES NOT ACCOUNT FOR THE ACTUAL BOARD STATE*)
  val generate_moves : position_key -> color -> position_key list
end

module Tree : sig
  type 'a t =
  | Leaf
  | Branch of {
    item: 'a t;
    nodes: 'a t list
    }
end

module Make_Piece (_ : Piece) : Piece
module Pawn : Piece
module Rook : Piece
module King : Piece
module Queen : Piece
module Bishop : Piece
module Knight : Piece
