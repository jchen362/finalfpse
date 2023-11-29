open Core

type piece_type = Pawn | Rook | Knight | Queen | King | Bishop
type color = Black | White
type position_key = { x : int; y : int } [@@deriving compare, sexp]

module Board_state : sig
  module Item_key : Map.Key with type t = position_key
  (* board state is a map of positions to pieces *)
  module Position_map : Map.S

  type t = Position_map

  (* creates a board state from a string *)
  (* LATER: talk about what is the exact format of the string*)
  val import : string -> t

  (* exports a board state into string form *)
  val export : t -> string

  (* default chess board state with no moved pieces *)
  val default_board : t

  (*Iterate through opposite peices to see if they can move to king
     To see if they can move to king:
        use valid move [PIECE_TYPE] to see

     valid move [PIECE_TYPE] uses can_move from piece module
    *)
  (* checks if given board state is in check 
     *)
  val in_check : t -> color -> bool

  (*Just going call valid_moves_piece to see if there are any valid moves -> if not then checkmate*)
  (* checks if given board state is in checkmate *)
  val in_checkmate : t -> color -> bool

  (* checks if given board state is in stalemate *)
  val in_stalemate : t -> color -> bool

  (* gets all possible moves for given piece *)
  (* Given a starting position, will generate a list of valid moves for that piece on the starting position
     Going to call generate_moves and fix using the board state*)
  (* Remember, valid_moves_piece has to consider if moving the piece there causes a check*)

  (*To further modularize the code -> will have a valid_moves_[PIECE_TYPE] functions for each type of piece (ex: bishop, queen, king, etc)*)
  val valid_moves_piece : t -> position_key -> position_key list

  (* gets all possible moves for given color *)
  (* It will repeatedly call valid_moves_piece for each piece of the specified color*)
  (*Then minimax can call this function*)
  val valid_moves_color : t -> color -> position_key list

  (* converts move from algebraic notation (e.g. Ke1) to pair of position_key *)
  val alg_to_pos : string -> (position_key * position_key) option

  (* converts move from pair of position_key to algebraic notation (e.g. Ke1) *)
  val pos_to_alg : (position_key * position_key) -> string

  (* takes in board state, start and end position, returns option saying move was successfully made and board state *)
  val move : t -> position_key -> position_key -> t option
end

(* NOTE: PAWN CAN BECOME QUEEN *)

module type Piece = sig
  val in_bounds : position_key -> bool

  (* sees if you can move a piece from start to end position DOES NOT ACCOUNT FOR ACTUAL BOARD STATE *)
  val can_move : position_key -> position_key -> bool

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

