open Core
open Lib

type piece_type = Pawn | Rook | Knight | Queen | King | Bishop

type map_value = {piece: piece_type; color: Lib.color}

module Board_state = 
  struct
    module Position_map = Map.Make(position_key)
    type t = map_value Position_map.t

    let import (str: string): t =

    let export (board: t): string =
    
    let default_board: t = 

    let rec aux_can_move (start: position_key) (dest: position_key) (current: position_key) (multiplier: position_key) : bool = 


    let can_move_vertical (start: position_key) (dest: position_key) : bool = 

    let can_move_horizontal (start: position_key) (dest: position_key) : bool = 

    let can_move_diagonal (start: position_key) (dest: position_key) : bool = 

    let in_check (board: t) (c: color): bool =

    let in_checkmate (board: t) (c: color): bool =

    let in_stalemate (board: t) (c: color): bool =

    let valid_moves_piece (board: t) (start: position_key): position_key list =

    let valid_moves_color (board: t) (c: color): position_key list =

    let alg_to_pos (str: string): (position_key * position_key) option = None

    let pos_to_alg (s: (position_key * position_key)): string = "None"

    let move : (board: t) (start: position_key) (dest: position_key): t option = None

  end