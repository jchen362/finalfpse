open Core

type piece_type = Pawn | Rook | Knight | Queen | King | Bishop
type color = Black | White
type map_value = { piece : piece_type; color : color }
type position_key = { x : int; y : int } [@@deriving compare, sexp]
type movement = { start : Lib.position_key; dest : Lib.position_key }

module Board_state : sig
  (* board state is a map of positions to pieces *)
  module Position_map : Map.S

  type t = map_value Position_map.t

  (* creates a board state from a string *)
  (* LATER: talk about what is the exact format of the string*)
  val import : string -> t option

  (* exports a board state into string form *)
  val export : t -> string
  val print_board : t -> unit

  (* default chess board state with no moved pieces *)
  val default_board : t

  (*Iterate through opposite peices to see if they can move to king
     To see if they can move to king:
        use valid move [PIECE_TYPE] to see

     valid move [PIECE_TYPE] uses can_move from piece module
  *)
  (* checks if given board state is in check 
     *)
  val in_check : t -> Lib.color -> bool

  (*Just going call valid_moves_piece to see if there are any valid moves -> if not then checkmate*)
  (* checks if given board state is in checkmate *)
  val in_checkmate : t -> Lib.color -> bool

  (* checks if given board state is in stalemate *)
  val in_stalemate : t -> color -> bool

  (* gets all possible moves for given piece *)
  (* Given a starting position, will generate a list of valid moves for that piece on the starting position
     Going to call generate_moves and fix using the board state*)
  (* Remember, valid_moves_piece has to consider if moving the piece there causes a check*)

  (*Checks to see if it is a valid_move*)
  val valid_move : t -> Lib.position_key -> Lib.position_key -> bool

  (*To further modularize the code -> will have a valid_moves_[PIECE_TYPE] functions for each type of piece (ex: bishop, queen, king, etc)*)
  val valid_moves_piece : t -> Lib.position_key -> movement list

  (* gets all possible moves for given color *)
  (* It will repeatedly call  s_piece for each piece of the specified color*)
  (*Then minimax can call this function*)
  val valid_moves_color : t -> Lib.color -> movement list

  (* takes in board state, start and end position, returns option saying move was successfully made and board state
     this is where I check whether or not the move results in pawn promotion*)
  val move : t -> Lib.position_key -> Lib.position_key -> t
  (*Gets the which color is the next turn given current player's color*)
  val next_player : Lib.color -> Lib.color
  (*Gets the piece at a specified position*)
  val get_piece : t -> Lib.position_key -> map_value
  (*Returns all positions that contain a piece in the board*)
  val get_keys : t -> Lib.position_key list
end
