open Core

type color = Black | White
type position_key = { x : int; y : int } [@@deriving compare, sexp]

module type Piece = sig
  val in_bounds : position_key -> bool

  (* sees if you can move a piece from start to end position DOES NOT ACCOUNT FOR ACTUAL BOARD STATE *)
  val can_move : position_key -> position_key -> color -> bool

  (* generates move for a piece based on possible positions DOES NOT ACCOUNT FOR THE ACTUAL BOARD STATE *)
  val generate_moves : position_key -> color -> position_key list
end

(*Notes:
   assumed x was horizontal, y was vertical, top left is 0, 0*)
module King : Piece = struct
  let in_bounds (pos : position_key) : bool =
    if pos.x < 0 || pos.x > 7 then false
    else if pos.y < 0 || pos.y > 7 then false
    else true

  let can_move (start : position_key) (dest : position_key) (curr_color : color)
      : bool =
    if not (in_bounds dest) then false
    else if abs (start.x - dest.x) + abs (start.y - dest.y) > 1 then false
    else true

  let rec generate_moves_king_helper (start : position_key)
      (add : position_key list) (ls : position_key list) : position_key list =
    match add with
    | [] -> ls
    | h :: t ->
        if in_bounds { x = start.x + h.x; y = start.y + h.y } then
          generate_moves_king_helper start t
            ({ x = start.x + h.x; y = start.y + h.y } :: ls)
        else generate_moves_king_helper start t ls

  let generate_moves (start : position_key) (c : color) : position_key list =
    if not (in_bounds start) then []
    else
      generate_moves_king_helper start
        [
          { x = 1; y = 0 };
          { x = 1; y = 1 };
          { x = 1; y = -1 };
          { x = 0; y = 1 };
          { x = 0; y = -1 };
          { x = -1; y = 0 };
          { x = -1; y = -1 };
          { x = -1; y = 1 };
        ]
        []
end

module Queen : Piece = struct
  let in_bounds (pos : position_key) : bool =
    if pos.x < 0 || pos.x > 7 then false
    else if pos.y < 0 || pos.y > 7 then false
    else true

  let can_move (start : position_key) (dest : position_key) (curr_color : color)
      : bool =
    if not (in_bounds dest) then false
    else if abs (start.x - dest.x) = abs (start.y - dest.y) then true
    else false

  let rec vert_up (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else vert_up { x = current.x; y = current.y - 1 } (current :: ls)

  let rec vert_down (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else vert_down { x = current.x; y = current.y + 1 } (current :: ls)

  let rec horizontal_left (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else horizontal_left { x = current.x - 1; y = current.y } (current :: ls)

  let rec horizontal_right (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else horizontal_right { x = current.x + 1; y = current.y } (current :: ls)

  let rec diag_right_up (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else diag_right_up { x = current.x + 1; y = current.y - 1 } (current :: ls)

  let rec diag_left_up (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else diag_left_up { x = current.x - 1; y = current.y + 1 } (current :: ls)

  let rec diag_right_down (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else diag_right_down { x = current.x + 1; y = current.y + 1 } (current :: ls)

  let rec diag_left_down (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else diag_left_down { x = current.x - 1; y = current.y - 1 } (current :: ls)

  (* TODO: add down left and down right? not sure if that's how this code works - bwong *)

  let generate_moves_helper (start : position_key) : position_key list =
    vert_up { x = start.x; y = start.y - 1 } []
    |> vert_down { x = start.x; y = start.y + 1 }
    |> horizontal_left { x = start.x - 1; y = start.y }
    |> horizontal_right { x = start.x + 1; y = start.y }
    |> diag_right_up { x = start.x + 1; y = start.y - 1 }
    |> diag_left_up { x = start.x - 1; y = start.y + 1 }
    |> diag_right_down { x = start.x + 1; y = start.y + 1 }
    |> diag_left_down { x = start.x - 1; y = start.y - 1 }

  let generate_moves (start : position_key) (c : color) : position_key list =
    if not (in_bounds start) then [] else generate_moves_helper start
end

module Pawn : Piece = struct
  let in_bounds (pos : position_key) : bool =
    if pos.x < 0 || pos.x > 7 then false
    else if pos.y < 0 || pos.y > 7 then false
    else true

  let is_first_move (pos : position_key) (curr_color : color) : bool =
    match curr_color with
    | White -> if pos.y = 6 then true else false
    | Black -> if pos.y = 1 then true else false

  let can_move (start : position_key) (dest : position_key) (curr_color : color)
      : bool =
    if not (in_bounds dest) then false
    else if
      is_first_move start curr_color
      && abs (start.y - dest.y) = 2
      && start.x = dest.x
    then true
    else if
      abs (start.y - dest.y) = 1
      && (start.x = dest.x || abs (start.x - dest.x) = 1)
    then true
    else false

  let move_up (current : position_key) (color_multiplier : int)
      (curr_color : color) : position_key list =
    if is_first_move current curr_color then
      [
        { x = current.x; y = current.y - (color_multiplier * 1) };
        { x = current.x; y = current.y - (color_multiplier * 2) };
      ]
    else [ { x = current.x; y = current.y - (color_multiplier * 1) } ]

  let move_left_diag (current : position_key) (color_multiplier : int)
      (ls : position_key list) : position_key list =
    if in_bounds { x = current.x - 1; y = current.y - (color_multiplier * 1) }
    then { x = current.x - 1; y = current.y - (color_multiplier * 1) } :: ls
    else ls

  let move_right_diag (current : position_key) (color_multiplier : int)
      (ls : position_key list) : position_key list =
    if in_bounds { x = current.x + 1; y = current.y - (color_multiplier * 1) }
    then { x = current.x + 1; y = current.y - (color_multiplier * 1) } :: ls
    else ls

  let generate_moves (start : position_key) (c : color) : position_key list =
    if not (in_bounds start) then []
    else
      let color_multiplier = match c with White -> 1 | Black -> -1 in
      move_up start color_multiplier c
      |> move_left_diag start color_multiplier
      |> move_right_diag start color_multiplier
end

module Rook : Piece = struct
  let in_bounds (pos : position_key) : bool =
    if pos.x < 0 || pos.x > 7 then false
    else if pos.y < 0 || pos.y > 7 then false
    else true

  let can_move (start : position_key) (dest : position_key) (curr_color : color)
      : bool =
    if not (in_bounds dest) then false
    else if start.x = dest.x || start.y = dest.y then true
    else false

  let rec move_rook_up (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else move_rook_up { x = current.x; y = current.y - 1 } (current :: ls)

  let rec move_rook_down (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else move_rook_down { x = current.x; y = current.y + 1 } (current :: ls)

  let rec move_rook_left (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else move_rook_left { x = current.x - 1; y = current.y } (current :: ls)

  let rec move_rook_right (current : position_key) (ls : position_key list) :
      position_key list =
    if not (in_bounds current) then ls
    else move_rook_right { x = current.x + 1; y = current.y } (current :: ls)

  let generate_moves (start : position_key) (c : color) : position_key list =
    if not (in_bounds start) then []
    else
      move_rook_up { x = start.x; y = start.y - 1 } []
      |> move_rook_down { x = start.x; y = start.y + 1 }
      |> move_rook_left { x = start.x - 1; y = start.y }
      |> move_rook_right { x = start.x + 1; y = start.y }
end

module Bishop : Piece = struct
  let in_bounds (pos : position_key) : bool =
    if pos.x < 0 || pos.x > 7 then false
    else if pos.y < 0 || pos.y > 7 then false
    else true

  (* sees if you can move a piece from start to end position DOES NOT ACCOUNT FOR ACTUAL BOARD STATE *)
  let can_move (start : position_key) (dest : position_key) (curr_color : color)
      : bool =
    if not (in_bounds dest) then false
    else if abs (start.x - dest.x) <> abs (start.y - dest.y) then false
    else true

  let diag_dirs : position_key list =
    [
      { x = 1; y = 1 }; { x = 1; y = -1 }; { x = -1; y = 1 }; { x = -1; y = -1 };
    ]

  (* generates moves backwards, must reverse at end *)
  let rec generate_diag_moves (start : position_key) (diag_dir : position_key) :
      position_key list =
    if not (in_bounds start) then []
    else
      match diag_dir with
      | { x; y } ->
          let new_pos = { x = start.x + x; y = start.y + y } in
          if in_bounds new_pos then
            new_pos :: generate_diag_moves start diag_dir
          else []

  (* generates move for a piece based on possible positions DOES NOT ACCOUNT FOR THE ACTUAL BOARD STATE *)
  let generate_moves (start : position_key) (c : color) : position_key list =
    List.concat_map diag_dirs ~f:(fun dir -> generate_diag_moves start dir)
end

module Knight : Piece = struct
  let in_bounds (pos : position_key) : bool =
    if pos.x < 0 || pos.x > 7 then false
    else if pos.y < 0 || pos.y > 7 then false
    else true

  (* sees if you can move a piece from start to end position DOES NOT ACCOUNT FOR ACTUAL BOARD STATE *)
  let can_move (start : position_key) (dest : position_key) (curr_color : color)
      : bool =
    if abs (start.x - dest.x) = 2 && abs (start.y - dest.y) = 1 then true
    else if abs (start.x - dest.x) = 1 && abs (start.y - dest.y) = 2 then true
    else false

  let knight_dirs : position_key list =
    [
      { x = 2; y = 1 };
      { x = 2; y = -1 };
      { x = 1; y = 2 };
      { x = 1; y = -2 };
      { x = -2; y = 1 };
      { x = -2; y = -1 };
      { x = -1; y = 2 };
      { x = -1; y = -2 };
    ]

  (* generates move for a piece based on possible positions DOES NOT ACCOUNT FOR THE ACTUAL BOARD STATE *)
  let generate_moves (start : position_key) (c : color) : position_key list =
    List.map knight_dirs ~f:(fun dir ->
        { x = start.x + dir.x; y = start.y + dir.y })
end
