open Core

[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-39"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-33"]

type piece_type = Pawn | Rook | Knight | Queen | King | Bishop
type color = Black | White [@@deriving equal]
type map_value = { piece : piece_type; color : color }
type position_key = { x : int; y : int } [@@deriving compare, sexp]

let white_pawn = { piece = Pawn; color = White }
let white_bishop = { piece = Bishop; color = White }
let white_knight = { piece = Knight; color = White }
let white_rook = { piece = Rook; color = White }
let white_queen = { piece = Queen; color = White }
let white_king = { piece = King; color = White }
let black_pawn = { piece = Pawn; color = Black }
let black_bishop = { piece = Bishop; color = Black }
let black_knight = { piece = Knight; color = Black }
let black_rook = { piece = Rook; color = Black }
let black_queen = { piece = Queen; color = Black }
let black_king = { piece = King; color = Black }

module Board_state = struct
  module Position_map = Map.Make (struct
    type t = position_key [@@deriving compare, sexp]
  end)

  type t = map_value Position_map.t

  let parse_piece (ch : char) : map_value option =
    match ch with
    | 'P' -> Some white_pawn
    | 'B' -> Some white_bishop
    | 'N' -> Some white_knight
    | 'R' -> Some white_rook
    | 'Q' -> Some white_queen
    | 'K' -> Some white_king
    | 'p' -> Some black_pawn
    | 'b' -> Some black_bishop
    | 'n' -> Some black_knight
    | 'r' -> Some black_rook
    | 'q' -> Some black_queen
    | 'k' -> Some black_king
    | _ -> None

  let rec add_piece (rank : char list) (acc : t) (x : int) (y : int)
      (piece : map_value option) : t option =
    match piece with
    | None -> None
    | Some piece -> (
        let pos : position_key = { x; y } in
        match Map.add acc ~key:pos ~data:piece with
        | `Duplicate -> None
        | `Ok new_map -> parse_rank rank new_map (x + 1) y)

  and parse_rank (rank : char list) (acc : t) (x : int) (y : int) : t option =
    match rank with
    | [] -> if x > 7 then Some acc else None
    | hd :: tl -> (
        match hd with
        | '1' .. '8' ->
            let count = Char.to_int hd - Char.to_int '0' in
            parse_rank tl acc (x + count) y
        | _ -> add_piece tl acc x y (parse_piece hd))

  let parse_fen_board (fen_board : string) (acc : t) (x : int) (y : int) :
      t option =
    let rec parse_fen_board_helper (ranks : string list) (acc : t) (x : int)
        (y : int) : t option =
      match ranks with
      | [] -> Some acc
      | hd :: tl -> (
          match parse_rank (String.to_list hd) acc x y with
          | Some board -> parse_fen_board_helper tl board x (y - 1)
          | None -> None)
    in
    let ranks = String.split_on_chars ~on:[ '/' ] fen_board in
    parse_fen_board_helper ranks acc x y

  let import (str : string) : t option =
    match String.split_on_chars ~on:[ ' ' ] str with
    | hd :: _ -> parse_fen_board hd Position_map.empty 0 7
    | [] -> None
  (* TODO: for now only handling positions *)

  let export_piece (piece : map_value) : char =
    match piece with
    | { piece = Pawn; color = White } -> 'P'
    | { piece = Bishop; color = White } -> 'B'
    | { piece = Knight; color = White } -> 'N'
    | { piece = Rook; color = White } -> 'R'
    | { piece = Queen; color = White } -> 'Q'
    | { piece = King; color = White } -> 'K'
    | { piece = Pawn; color = Black } -> 'p'
    | { piece = Bishop; color = Black } -> 'b'
    | { piece = Knight; color = Black } -> 'n'
    | { piece = Rook; color = Black } -> 'r'
    | { piece = Queen; color = Black } -> 'q'
    | { piece = King; color = Black } -> 'k'

  let export_rank (board : t) (x : int) (y : int) : string =
    let rec export_rank_helper (board : t) (count : int) (x : int) (y : int)
        (acc : char list) : char list =
      if x > 7 then acc
      else
        let pos : position_key = { x; y } in
        let piece = Map.find board pos in
        match piece with
        | None -> export_rank_helper board (count + 1) (x + 1) y acc
        | Some p ->
            (* Char.of_int_exn because count always <= 8 *)
            export_rank_helper board 0 (x + 1) y
              (export_piece p :: Char.of_int_exn count :: acc)
    in
    export_rank_helper board 0 x y [] |> List.rev |> String.of_char_list

  let export_ranks (board : t) : string list =
    List.init 8 ~f:(fun y -> export_rank board 0 y) |> List.rev

  let export (board : t) : string =
    let ranks = export_ranks board in
    String.concat ~sep:"/" ranks
  (* TODO: for now only handling positions *)

  let default_board : t =
    let white_positions =
      [
        ({ x = 0; y = 0 }, white_rook);
        ({ x = 1; y = 0 }, white_knight);
        ({ x = 2; y = 0 }, white_bishop);
        ({ x = 3; y = 0 }, white_queen);
        ({ x = 4; y = 0 }, white_king);
        ({ x = 5; y = 0 }, white_bishop);
        ({ x = 6; y = 0 }, white_knight);
        ({ x = 7; y = 0 }, white_rook);
        ({ x = 0; y = 1 }, white_pawn);
        ({ x = 1; y = 1 }, white_pawn);
        ({ x = 2; y = 1 }, white_pawn);
        ({ x = 3; y = 1 }, white_pawn);
        ({ x = 4; y = 1 }, white_pawn);
        ({ x = 5; y = 1 }, white_pawn);
        ({ x = 6; y = 1 }, white_pawn);
        ({ x = 7; y = 1 }, white_pawn);
      ]
    in
    let black_positions =
      [
        ({ x = 0; y = 7 }, black_rook);
        ({ x = 1; y = 7 }, black_knight);
        ({ x = 2; y = 7 }, black_bishop);
        ({ x = 3; y = 7 }, black_queen);
        ({ x = 4; y = 7 }, black_king);
        ({ x = 5; y = 7 }, black_bishop);
        ({ x = 6; y = 7 }, black_knight);
        ({ x = 7; y = 7 }, black_rook);
        ({ x = 0; y = 6 }, black_pawn);
        ({ x = 1; y = 6 }, black_pawn);
        ({ x = 2; y = 6 }, black_pawn);
        ({ x = 3; y = 6 }, black_pawn);
        ({ x = 4; y = 6 }, black_pawn);
        ({ x = 5; y = 6 }, black_pawn);
        ({ x = 6; y = 6 }, black_pawn);
        ({ x = 7; y = 6 }, black_pawn);
      ]
    in
    Position_map.of_alist_exn (white_positions @ black_positions)

<<<<<<< HEAD
  let aux_can_move (start : position_key) (dest : position_key)
=======
  let rec aux_can_move (board_state : t) (start : position_key) (dest : position_key)
>>>>>>> 628b15a (adding aux functions to check can_move)
      (current : position_key) (multiplier : position_key) : bool =
    let start_piece = Map.find_exn board_state start
    in
    if (current.x = dest.x) && (current.y = dest.y) then
      (* base case *)
      match Map.find board_state current with
      | None -> true
      | Some dest_piece_info ->
        if (equal_color start_piece.color dest_piece_info.color) then false
        else true
    else
      match Map.find board_state current with
      | None ->
        aux_can_move board_state start dest {x = (current.x + multiplier.x); y = (current.y + multiplier.y)} multiplier
      | Some _ -> false

  let can_move_vertical (board_state : t) (start : position_key) (dest : position_key) : bool =
    if (start.x = dest.x) && (start.y = dest.y) then
      false
    else
      let multiplier = 
      if (start.y - dest.y) > 0 then
        (* piece is moving up *)
        {x = 0; y = -1}
      else if (start.y - dest.y) < 0 then 
        (* piece is moving down *)
        {x = 0; y = 1}
      else
        (* no movement *)
        {x = 0; y = 0}
      in
      aux_can_move board_state start dest {x = (start.x + multiplier.x); y = (start.y + multiplier.y)} multiplier

  let can_move_horizontal (board_state : t) (start : position_key) (dest : position_key) : bool =
    if (start.x = dest.x) && (start.y = dest.y) then
      false
    else
      let multiplier = 
      if (start.x - dest.x) > 0 then
        (* piece is moving left *)
        {x = -1; y = 0}
      else if (start.x - dest.x) < 0 then 
        (* piece is moving right *)
        {x = 1; y = 0}
      else
        (* no movement *)
        {x = 0; y = 0}
      in
      aux_can_move board_state start dest {x = (start.x + multiplier.x); y = (start.y + multiplier.y)} multiplier

  let can_move_diagonal (board_state : t) (start : position_key) (dest : position_key) : bool =
    if (start.x = dest.x) && (start.y = dest.y) then
      false
    else
      let multiplier = 
      if (start.x - dest.x) > 0 && (start.y - dest.y) > 0 then
        (* piece is moving up-left *)
        {x = -1; y = -1}
      else if (start.x - dest.x) < 0 && (start.y - dest.y) > 0 then 
        (* piece is moving up-right *)
        {x = 1; y = -1}
      else if (start.x - dest.x) > 0 && (start.y - dest.y) < 0 then 
        (* piece is moving down-left *)
        {x = -1; y = 1}
      else if (start.x - dest.x) < 0 && (start.y - dest.y) < 0 then 
        (* piece is moving down-right *)
        {x = 1; y = 1}
      else
        (* no movement *)
        {x = 0; y = 0}
      in
      aux_can_move board_state start dest {x = (start.x + multiplier.x); y = (start.y + multiplier.y)} multiplier

  let in_check (board : t) (c : color) : bool = false
  let in_checkmate (board : t) (c : color) : bool = false
  let in_stalemate (board : t) (c : color) : bool = false

  let valid_moves_piece (board : t) (start : position_key) : position_key list =
    []

  let valid_moves_color (board : t) (c : color) : position_key list = []
  let alg_to_pos (str : string) : (position_key * position_key) option = None
  let pos_to_alg (s : position_key * position_key) : string = "None"

  let move (board : t) (start : position_key) (dest : position_key) : t option =
    None
end
