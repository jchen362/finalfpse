open Core

type piece_type = Pawn | Rook | Knight | Queen | King | Bishop
type color = Black | White [@@deriving equal]
type map_value = { piece : piece_type; color : color }
type position_key = { x : int; y : int } [@@deriving compare, sexp]

module Board_state : sig
  
  (* board state is a map of positions to pieces *)
  module Position_map : Map.S

  type t = map_value Position_map.t

  (* creates a board state from a string *)
  (* LATER: talk about what is the exact format of the string*)
  val import : string -> t option

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
  val pos_to_alg : position_key * position_key -> string

  (* takes in board state, start and end position, returns option saying move was successfully made and board state *)
  val move : t -> position_key -> position_key -> t option
end
