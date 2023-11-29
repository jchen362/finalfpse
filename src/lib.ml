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

(*Notes:
   assumed x was horizontal, y was vertical, top left is 0, 0*)
module King : Piece =
  struct
    let in_bounds (pos: position_key): bool =
      if pos.x < 0 || pos.x > 7 then false
      else if pos.y < 0 || pos.y > 7 then false
      else true

    let can_move (start: position_key) (dest: position_key): bool =
      if not (in_bounds dest) then false
      else if (abs (start.x - dest.x) + abs (start.y - dest.y)) > 1 then false
      else true

    let rec generate_moves_king_helper (start: position_key) (add: position_key list) (ls: position_key list): position_key list =
      match add with
      | [] -> ls
      | h::t ->
        if in_bounds ({x = start.x + h.x; y = start.y + h.y}) then generate_moves_king_helper start t ({x = start.x + h.x; y = start.y + h.y} :: ls)
        else generate_moves_king_helper start t ls
    let generate_moves (start: position_key) (c: color): position_key list =
      if not (in_bounds start) then []
      else generate_moves_king_helper start ([{x = 1; y = 0}; {x = 1; y = 1}; {x = 1; y = -1}; {x = 0; y = 1}; {x = 0; y = -1}; {x = -1; y = 0}; {x = -1; y = -1}; {x = -1; y = 1}]) []
  end

  module Queen: Piece =
  struct
    let in_bounds (pos: position_key): bool =
      if pos.x < 0 || pos.x > 7 then false
      else if pos.y < 0 || pos.y > 7 then false
      else true

    let can_move (start: position_key) (dest: position_key): bool =
      if not (in_bounds dest) then false
      else if abs (start.x - dest.x) = abs (start.y - dest.y) then true
      else false

    let rec vert_up (current: position_key) (ls: position_key list): position_key list =
      if not (in_bounds current) then ls
      else vert_up ({x = current.x; y = current.y - 1}) (current :: ls)
  
    let rec vert_down (current: position_key) (ls: position_key list): position_key list =
      if not (in_bounds current) then ls
      else vert_down ({x = current.x; y = current.y + 1}) (current :: ls)
  
    let rec horizontal_left (current: position_key) (ls: position_key list): position_key list =
        if not (in_bounds current) then ls
        else horizontal_left ({x = current.x - 1; y = current.y}) (current :: ls)
  
    let rec horizontal_right (current: position_key) (ls: position_key list): position_key list =
      if not (in_bounds current) then ls
      else horizontal_right ({x = current.x + 1; y = current.y}) (current :: ls)
    
    let rec diag_right (current: position_key) (ls: position_key list): position_key list =
      if not (in_bounds current) then ls
      else diag_right ({x = current.x + 1; y = current.y + 1}) (current :: ls)

    let rec diag_left (current: position_key) (ls: position_key list): position_key list =
      if not (in_bounds current) then ls
      else diag_right ({x = current.x - 1; y = current.y - 1}) (current :: ls)

    let generate_moves_helper (start: position_key): position_key list =
      vert_up ({x = start.x; y = start.y - 1}) [] 
      |> vert_down ({x = start.x; y = start.y + 1}) 
      |> horizontal_left ({x = start.x - 1; y = start.y}) 
      |> horizontal_right ({x = start.x + 1; y = start.y})
      |> diag_right ({x = start.x + 1; y = start.y + 1})
      |> diag_left ({x = start.x - 1; y = start.y - 1})

    let generate_moves (start: position_key) (c: color): position_key list =
      if not (in_bounds start) then []
      else generate_moves_helper start

  end