open Core
open Lib

[@@@ocaml.warning "-27"]
[@@@ocaml.warning "-32"]

module type Evaluation = sig
  val pawn_score : float array array
  val knight_score : float array array
  val rook_score : float array array
  val queen_score : float array array
  val king_score : float array array
  val bishop_score : float array array

  (* returns a score for passed board state*)
  val evaluate : Board.Board_state.t -> float
end

module Eval : Evaluation = struct
  let pawn_score = [| 
  [| 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 |];
  [| 5.0; 5.0; 5.0; 5.0; 5.0; 5.0; 5.0; 5.0 |]; 
  [| 1.0; 1.0; 2.0; 3.0; 3.0; 2.0; 1.0; 1.0 |];
  [| 0.5; 0.5; 1.0; 2.5; 2.5; 1.0; 0.5; 0.5 |];
  [| 0.0; 0.0; 0.0; 2.0; 2.0; 0.0; 0.0; 0.0 |]; 
  [| 0.5; -0.5; -1.0; 0.0; 0.0; -1.0; -0.5; 0.5 |];
  [| 0.5; 1.0; 1.0; -2.0; -2.0; 1.0; 1.0; 0.5 |]; 
  [| 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 |]
  |]
  let knight_score = [| 
  [| -5.0; -4.0; -3.0; -3.0; -3.0; -3.0; -4.0; -5.0 |];
  [| -4.0; -2.0; 0.0; 0.0; 0.0; 0.0; -2.0; -4.0 |];
  [| -3.0; 0.0; 1.0; 1.5; 1.5; 1.0; 0.0; -3.0 |];
  [| -3.0; 0.5; 1.5; 2.0; 2.0; 1.5; 0.5; -3.0 |];
  [| -3.0; 0.0; 1.5; 2.0; 2.0; 1.5; 0.0; -3.0 |];
  [| -3.0; 0.5; 1.0; 1.5; 1.5; 1.0; 0.5; -3.0 |];
  [| -4.0; -2.0; 0.0; 0.5; 0.5; 0.0; -2.0; -4.0 |];
  [| -5.0; -4.0; -3.0; -3.0; -3.0; -3.0; -4.0; -5.0 |]
  |] 
  let rook_score = [| 
  [| 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0 |];
  [| 0.5; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 0.5 |];
  [| -0.5; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -0.5 |];
  [| -0.5; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -0.5 |];
  [| -0.5; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -0.5 |];
  [| -0.5; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -0.5 |];
  [| -0.5; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -0.5 |];
  [| 0.0; 0.0; 0.0; 0.5; 0.5; 0.0; 0.0; 0.0 |]
   |] 
  let queen_score = [| 
  [| -2.0; -1.0; -1.0; -0.5; -0.5; -1.0; -1.0; -2.0 |];
  [| -1.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -1.0 |];
  [| -1.0; 0.0; 0.5; 0.5; 0.5; 0.5; 0.0; -1.0 |];
  [| -0.5; 0.0; 0.5; 0.5; 0.5; 0.5; 0.0; -0.5 |];
  [| 0.0; 0.0; 0.5; 0.5; 0.5; 0.5; 0.0; -0.5 |];
  [| -1.0; 0.5; 0.5; 0.5; 0.5; 0.5; 0.0; -1.0 |];
  [| -1.0; 0.0; 0.5; 0.0; 0.0; 0.0; 0.0; -1.0 |];
  [| -2.0; -1.0; -1.0; -0.5; -0.5; -1.0; -1.0; -2.0 |]
   |] 
  let king_score = [| 
  [| -3.0; -4.0; -4.0; -5.0; -5.0; -4.0; -4.0; -3.0 |];
  [| -3.0; -4.0; -4.0; -5.0; -5.0; -4.0; -4.0; -3.0 |];
  [| -3.0; -4.0; -4.0; -5.0; -5.0; -4.0; -4.0; -3.0 |];
  [| -3.0; -4.0; -4.0; -5.0; -5.0; -4.0; -4.0; -3.0 |];
  [| -2.0; -3.0; -3.0; -4.0; -4.0; -3.0; -3.0; -2.0 |];
  [| -1.0; -2.0; -2.0; -2.0; -2.0; -2.0; -2.0; -1.0 |];
  [| 2.0; 2.0; 0.0; 0.0; 0.0; 0.0; 2.0; 2.0 |];
  [| 2.0; 3.0; 1.0; 0.0; 0.0; 1.0; 3.0; 2.0 |]
  |] 
  let bishop_score = [| 
  [| -2.0; -1.0; -1.0; -1.0; -1.0; -1.0; -1.0; -2.0 |];
  [| -1.0; 0.0; 0.0; 0.0; 0.0; 0.0; 0.0; -1.0 |];
  [| -1.0; 0.0; 0.5; 1.0; 1.0; 0.5; 0.0; -1.0 |];
  [| -1.0; 0.5; 0.5; 1.0; 1.0; 0.5; 0.5; -1.0 |];
  [| -1.0; 0.0; 1.0; 1.0; 1.0; 1.0; 0.0; -1.0 |];
  [| -1.0; 1.0; 1.0; 1.0; 1.0; 1.0; 1.0; -1.0 |];
  [| -1.0; 0.5; 0.0; 0.0; 0.0; 0.0; 0.5; -1.0 |];
  [| -2.0; -1.0; -1.0; -1.0; -1.0; -1.0; -1.0; -2.0 |]
  |]

  let get_y (piece_color : Board.color) (y_cor : int) : int =
    match piece_color with 
    | Board.White -> y_cor
    | Board.Black -> (7 - y_cor)

  let get_multiplier (piece_color : Board.color) : float =
    match piece_color with 
    | Board.White -> 1.
    | Board.Black -> -1.


  let evaluate (board : Board.Board_state.t) : float =
    let rec calculate_score (pos_keys : Lib.position_key list) : float =
      match pos_keys with
      | [] -> 0.0
      | curr_key :: rem_keys ->
        let curr_piece_info = (Board.Board_state.get_piece board curr_key) in
        let abs_score =
          match curr_piece_info.piece with
          | Board.Pawn ->
            Float.((10. + pawn_score.(get_y curr_piece_info.color curr_key.y).(curr_key.x)))
          | Board.Rook -> 
            Float.((50. + rook_score.(get_y curr_piece_info.color curr_key.y).(curr_key.x)))
          | Board.Queen -> 
            Float.((90. + queen_score.(get_y curr_piece_info.color curr_key.y).(curr_key.x)))
          | Board.King -> 
            Float.((900. + king_score.(get_y curr_piece_info.color curr_key.y).(curr_key.x)))
          | Board.Bishop -> 
            Float.((30. + bishop_score.(get_y curr_piece_info.color curr_key.y).(curr_key.x)))
          | Board.Knight -> 
            Float.((30. + knight_score.(get_y curr_piece_info.color curr_key.y).(curr_key.x)))
      in
      Float.(((get_multiplier curr_piece_info.color) * abs_score) + (calculate_score rem_keys))
    in
    calculate_score (Board.Board_state.get_keys board)
end

module type Minimax = sig
  include Evaluation

  (* likely 5 levels of difficulty, each level has static alpha beta values to be used
     for pruning which essentially decides the depth of the search tree *)
  (* module Difficulty_map : Map.Make(Int); value is alpha_beta *)
  module Difficulty_map : Map.S

  (* generates the next move based on the difficulty provided *)
  val generate_next_move : string -> char -> int -> string
end

module Minimax : Minimax = struct
  include Eval

  (* likely 5 levels of difficulty, each level has static alpha beta values to be used
     for pruning which essentially decides the depth of the search tree *)
  (* module Difficulty_map : Map.Make(Int); value is alpha_beta *)
  (* module Difficulty_map : Map.S *)
  module Difficulty_map = Map.Make(Int)

  let org_alpha = 100000.0
  let org_beta = -100000.0
  let difficulty_map = 
  Difficulty_map.empty 
  |> Map.add_exn ~key:(1) ~data:(2) 
  |> Map.add_exn ~key:(2) ~data:(3)
  |> Map.add_exn ~key:(3) ~data:(4)

  let rec minimax (board : Board.Board_state.t) (depth : int) (maximizePlayer : bool) (curr_color : Lib.color) (alpha : float) (beta : float) : float =
    if depth = 0 then
      Float.(-(evaluate board))
    else
      if maximizePlayer then
        let rec get_max_val (all_moves : Board.movement list) (max_val : float) (aux_alpha : float) : float =
          match all_moves with
          | [] -> max_val
          | move :: rem_moves ->
            let current_board = Board.Board_state.move board move.start move.dest in
            let move_value = minimax current_board (depth - 1) false (Board.Board_state.next_player curr_color) aux_alpha beta in
            let new_max_val = Float.max max_val move_value in
            let new_alpha = Float.max aux_alpha new_max_val in
            if Float.(beta <= new_alpha) then
              new_max_val
            else
              get_max_val rem_moves new_max_val new_alpha
        in
        get_max_val (Board.Board_state.valid_moves_color board curr_color) Float.min_value alpha

      else
        let rec get_min_val (all_moves : Board.movement list) (min_val : float) (aux_beta : float) : float =
          match all_moves with
          | [] -> min_val
          | move :: rem_moves ->
            let current_board = Board.Board_state.move board move.start move.dest in
            let move_value = minimax current_board (depth - 1) true (Board.Board_state.next_player curr_color) alpha aux_beta in
            let new_min_val = Float.min min_val move_value in
            let new_beta = Float.min aux_beta new_min_val in
            if Float.(new_beta <= alpha) then
              new_min_val
            else
              get_min_val rem_moves new_min_val new_beta
        in
        get_min_val (Board.Board_state.valid_moves_color board curr_color) Float.max_value beta
  
  let generate_updated_board (board : Board.Board_state.t) (curr_color : Lib.color) (depth : int) (alpha : float) (beta : float) : string =
    let rec aux_generate_next_best_move (all_next_moves : Board.movement list) (best_move : Board.movement) (max_val : float) (aux_alpha : float) : float * Board.movement =
      match all_next_moves with
        | [] -> (max_val, best_move)
        | move :: rem_moves ->
          let current_board = Board.Board_state.move board move.start move.dest in
          let move_value = minimax current_board (depth - 1) false (Board.Board_state.next_player curr_color) aux_alpha beta in
          let new_max_val = Float.max max_val move_value in
          let new_best_move = 
          if Float.(new_max_val > max_val) then move
          else best_move
          in
          let new_alpha = Float.max aux_alpha new_max_val in
          if Float.(beta <= new_alpha) then
            (new_max_val, new_best_move)
          else
            aux_generate_next_best_move rem_moves new_best_move max_val new_alpha
    in
    let all_valid_moves = (Board.Board_state.valid_moves_color board curr_color) in
    if (List.length all_valid_moves) = 0 then
      Board.Board_state.export board
    else
      let _, next_move = aux_generate_next_best_move all_valid_moves Board.({start = {x = -1; y = -1}; dest = {x = -1; y = -1}}) Float.min_value alpha
      in
      (Board.Board_state.move board next_move.start next_move.dest)
      |> Board.Board_state.export

  let convert_color (color_code : char) : Lib.color =
    if (Char.equal color_code 'B') then
      Lib.Black
    else
      Lib.White

  (* generates the next move based on the difficulty provided *)
  let generate_next_move (start_board_str : string) (player_color : char) (difficulty : int) : string =
    match (Board.Board_state.import start_board_str) with
    | None -> start_board_str
    | Some board_state ->
      match (Map.find difficulty_map difficulty) with
      | None -> start_board_str
      | Some depth ->
        generate_updated_board board_state (convert_color player_color) depth org_alpha org_beta           
end
