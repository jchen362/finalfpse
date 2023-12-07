open Core
include Lib

[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-39"]
[@@@ocaml.warning "-32"]
[@@@ocaml.warning "-33"]

type piece_type = Pawn | Rook | Knight | Queen | King | Bishop
type map_value = { piece : piece_type; color : Lib.color }
type movement = {start: Lib.position_key; dest: Lib.position_key}

type move_direction = Vertical | Horizontal | Diagonal

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
    type t = Lib.position_key [@@deriving compare, sexp]
  end)

  type t = map_value Position_map.t

  (*Returns true if they are the same color*)
  let matches_color (c1: Lib.color) (c2: Lib.color): bool =
    match c1, c2 with
    | Black, Black -> true
    | White, White -> true
    | _,_ -> false

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
        let pos : Lib.position_key = { x; y } in
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
        let pos : Lib.position_key = { x; y } in
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


  let rec aux_can_move (board_state : t) (start : Lib.position_key) (dest : Lib.position_key)
      (current : Lib.position_key) (multiplier : Lib.position_key) : bool =
    let start_piece = Map.find_exn board_state start
    in
    if (current.x = dest.x) && (current.y = dest.y) then
      (* base case *)
      match Map.find board_state current with
      | None -> true
      | Some dest_piece_info ->
        if (matches_color start_piece.color dest_piece_info.color) then false
        else true
    else
      match Map.find board_state current with
      | None ->
        aux_can_move board_state start dest {x = (current.x + multiplier.x); y = (current.y + multiplier.y)} multiplier
      | Some _ -> false

  let can_move_vertical (board_state : t) (start : Lib.position_key) (dest : Lib.position_key) : bool =
    if (start.x = dest.x) && (start.y = dest.y) then
      false
    else
      let multiplier: Lib.position_key = 
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

  let can_move_horizontal (board_state : t) (start : Lib.position_key) (dest : Lib.position_key) : bool =
    if (start.x = dest.x) && (start.y = dest.y) then
      false
    else
      let multiplier: Lib.position_key = 
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

  let can_move_diagonal (board_state : t) (start : Lib.position_key) (dest : Lib.position_key) : bool =
    if (start.x = dest.x) && (start.y = dest.y) then
      false
    else
      let multiplier: Lib.position_key = 
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

  let in_check (board : t) (c : Lib.color) : bool = false
  let in_checkmate (board : t) (c : Lib.color) : bool = false
  let in_stalemate (board : t) (c : Lib.color) : bool = false

  let teammate_in_pos (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool =
    let col = (Map.find_exn board start).color
    in
    match Map.find board dest with
    | None -> false
    | Some x ->
      begin match x.color, col with
      | Lib.Black, Lib.Black -> true
      | Lib.White, Lib.White -> true
      | _,_ -> false
      end

  let aux_get_move_direction (start : position_key) (dest : position_key) : move_direction =
    let x_diff = abs (start.x - dest.x)
    in
    let y_diff = abs (start.y - dest.y)
    in
    if x_diff = 0 && y_diff > 0 then Vertical
    else if x_diff > 0 && y_diff = 0 then Horizontal
    else Diagonal

  let valid_move_king (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool =
    (*Teammate is already in destination*)
    if not (teammate_in_pos board start dest) then false
    else true

  let valid_move_queen (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool =
    if not (dest.x - start.x = 0) && not (dest.y - start.y = 0) then can_move_diagonal board start dest
    else if (dest.x - start.x = 0) && not (dest.y - start.y = 0) then can_move_vertical board start dest
    else if (dest.x - start.x = 0) && (dest.y - start.y = 0) then false
    else can_move_horizontal board start dest

  let valid_move_bishop (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool =
    match (aux_get_move_direction start dest) with
    | Vertical -> false
    | Horizontal -> false
    | Diagonal -> can_move_diagonal board start dest

  let valid_move_knight (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool = 
    match (aux_get_move_direction start dest) with
    | Vertical -> false
    | Horizontal -> false
    | Diagonal -> can_move_diagonal board start dest
    
  let valid_move_pawn (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool =
    match (aux_get_move_direction start dest) with
    | Vertical -> can_move_vertical board start dest
    | Horizontal -> can_move_horizontal board start dest
    | Diagonal ->
      match (Map.find board dest) with
      | None -> false
      | Some _ -> can_move_diagonal board start dest

  let valid_move_rook (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool =
    match (aux_get_move_direction start dest) with
    | Vertical -> can_move_vertical board start dest
    | Horizontal -> can_move_horizontal board start dest
    | Diagonal -> false

  (*Checks to see if it is a valid_move*)
  let valid_move (board: t) (start: Lib.position_key) (dest: Lib.position_key): bool =
    match Map.find board start with
    | None -> false
    | Some x -> begin match x.piece with
      | Pawn -> valid_move_pawn board start dest
      | Knight -> valid_move_knight board start dest
      | Rook -> valid_move_rook board start dest
      | Bishop -> valid_move_bishop board start dest
      | Queen -> valid_move_queen board start dest
      | King -> valid_move_king board start dest
      end

  (*Helper method for valid_moves_piece*)
  let rec valid_moves_piece_helper (board: t) (start: Lib.position_key) (ls: Lib.position_key list) (valid_ls: movement list): movement list =
    match ls with
    | [] -> valid_ls
    | h::t ->
      if valid_move board start h then valid_moves_piece_helper board start t ({start = start; dest = h} :: valid_ls)
      else valid_moves_piece_helper board start t valid_ls

  (*Returns all valid moves for a given piece in {start, end} format for each element*)
  let valid_moves_piece (board : t) (start : Lib.position_key) : movement list =
    match Map.find board start with
    | None -> []
    | Some x -> begin match x.piece with
      | Pawn -> valid_moves_piece_helper board start (Lib.Pawn.generate_moves start x.color) []
      | Knight -> valid_moves_piece_helper board start (Lib.Knight.generate_moves start x.color) []
      | Rook -> valid_moves_piece_helper board start (Lib.Rook.generate_moves start x.color) []
      | Bishop -> valid_moves_piece_helper board start (Lib.Bishop.generate_moves start x.color) []
      | Queen -> valid_moves_piece_helper board start (Lib.Queen.generate_moves start x.color) []
      | King -> valid_moves_piece_helper board start (Lib.King.generate_moves start x.color) []
      end
  
  (*Returns all possible moves given a color*)
  let valid_moves_color (board : t) (c : Lib.color) : movement list =
    Map.fold board ~init:[] ~f:(fun ~key:key ~data:data accum -> if matches_color data.color c then accum @ (valid_moves_piece board key) else accum)

  let alg_to_pos (str : string) : (Lib.position_key * Lib.position_key) option = None
  let pos_to_alg (s : Lib.position_key * Lib.position_key) : string = "None"

  let move (board : t) (start : Lib.position_key) (dest : Lib.position_key) : t option =
    None
end
