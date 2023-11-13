open Core


type piece_type = Pawn | Rook | Knight | Queen | King | Bishop
type color = Black | White


type position_key = {x: int; y: int} [@@deriving compare, sexp]

module Board_State: sig
    module Item_Key : Map.Key with type t = position_key
    type t
    val import: string -> t
    val export: t -> string
    val in_check: t -> color -> bool
    val in_checkmate: t -> color -> bool 
    val in_stalemate: t -> color -> bool


end


module type Piece = 
    sig
        val piece: string
        val calculate_valid_moves: int -> int -> (*board state*) -> int list
    end

module Pawn: Piece
module Rook: Piece
module King: Piece
module Queen: Piece
module Bishop: Piece
module Knight: Piece