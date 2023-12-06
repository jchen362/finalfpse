open Core
open OUnit2
open Lib

[@@@ocaml.warning "-32"]
(* type position_key = {x : int; y : int} [@@deriving compare, sexp] *)

let pos_in = { x = 3; y = 4 }
let pos_out_x1 = { x = 8; y = 1 }
let pos_out_x2 = { x = -1; y = 1 }
let pos_out_y1 = { x = 1; y = 8 }
let pos_out_y2 = { x = 1; y = -1 }

let test_in_bounds _ =
  assert_equal true @@ Pawn.in_bounds pos_in;
  assert_equal true @@ Bishop.in_bounds pos_in;
  assert_equal true @@ Knight.in_bounds pos_in;
  assert_equal true @@ Rook.in_bounds pos_in;
  assert_equal true @@ Queen.in_bounds pos_in;
  assert_equal true @@ King.in_bounds pos_in

let test_out_bounds_x1 _ =
  assert_equal false @@ Pawn.in_bounds pos_out_x1;
  assert_equal false @@ Bishop.in_bounds pos_out_x1;
  assert_equal false @@ Knight.in_bounds pos_out_x1;
  assert_equal false @@ Rook.in_bounds pos_out_x1;
  assert_equal false @@ Queen.in_bounds pos_out_x1;
  assert_equal false @@ King.in_bounds pos_out_x1

let test_out_bounds_x2 _ =
  assert_equal false @@ Pawn.in_bounds pos_out_x2;
  assert_equal false @@ Bishop.in_bounds pos_out_x2;
  assert_equal false @@ Knight.in_bounds pos_out_x2;
  assert_equal false @@ Rook.in_bounds pos_out_x2;
  assert_equal false @@ Queen.in_bounds pos_out_x2;
  assert_equal false @@ King.in_bounds pos_out_x2

let test_out_bounds_y1 _ =
  assert_equal false @@ Pawn.in_bounds pos_out_y1;
  assert_equal false @@ Bishop.in_bounds pos_out_y1;
  assert_equal false @@ Knight.in_bounds pos_out_y1;
  assert_equal false @@ Rook.in_bounds pos_out_y1;
  assert_equal false @@ Queen.in_bounds pos_out_y1;
  assert_equal false @@ King.in_bounds pos_out_y1

let test_out_bounds_y2 _ =
  assert_equal false @@ Pawn.in_bounds pos_out_y2;
  assert_equal false @@ Bishop.in_bounds pos_out_y2;
  assert_equal false @@ Knight.in_bounds pos_out_y2;
  assert_equal false @@ Rook.in_bounds pos_out_y2;
  assert_equal false @@ Queen.in_bounds pos_out_y2;
  assert_equal false @@ King.in_bounds pos_out_y2

let default_pos_black_pawn = { x = 4; y = 1 }
let start_pos = { x = 4; y = 4 }

let end_pos_vert =
  [
    { x = 4; y = 7 };
    { x = 4; y = 6 };
    { x = 4; y = 5 };
    { x = 4; y = 0 };
    { x = 4; y = 1 };
    { x = 4; y = 2 };
    { x = 4; y = 3 };
  ]

let end_pos_horiz =
  [
    { x = 7; y = 4 };
    { x = 6; y = 4 };
    { x = 5; y = 4 };
    { x = 0; y = 4 };
    { x = 1; y = 4 };
    { x = 2; y = 4 };
    { x = 3; y = 4 };
  ]

let end_pos_diag_positive =
  [
    { x = 0; y = 0 };
    { x = 1; y = 1 };
    { x = 2; y = 2 };
    { x = 3; y = 3 };
    { x = 5; y = 5 };
    { x = 6; y = 6 };
    { x = 7; y = 7 };
  ]

let end_pos_diag_negative =
  [
    { x = 1; y = 7 };
    { x = 2; y = 6 };
    { x = 3; y = 5 };
    { x = 5; y = 3 };
    { x = 6; y = 2 };
    { x = 7; y = 1 };
  ]

let end_pos_default_black_pawn =
  [{ x = 5; y = 2 }; { x = 3; y = 2 }; { x = 4; y = 2 }; { x = 4; y = 3 }]

let end_pos_black_pawn =
  [{ x = 5; y = 5 }; { x = 3; y = 5 }; { x = 4; y = 5 }]

let end_pos_knight =
  [
    { x = 2; y = 3 };
    { x = 6; y = 3 };
    { x = 2; y = 5 };
    { x = 6; y = 5 };
    { x = 3; y = 2 };
    { x = 3; y = 6 };
    { x = 5; y = 2 };
    { x = 5; y = 6 };
  ]

let end_pos_king =
  [
    { x = 3; y = 3 };
    { x = 4; y = 3 };
    { x = 5; y = 3 };
    { x = 3; y = 4 };
    { x = 5; y = 4 };
    { x = 3; y = 5 };
    { x = 4; y = 5 };
    { x = 5; y = 5 };
  ]

let test_pawn_can_move _ =
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Pawn.can_move start_pos end_pos Black)
       end_pos_black_pawn;
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Pawn.can_move default_pos_black_pawn end_pos Black)
       end_pos_default_black_pawn

let test_pawn_generate_moves _ = 
  assert_equal end_pos_default_black_pawn 
  @@ (Pawn.generate_moves default_pos_black_pawn Black);
  assert_equal end_pos_black_pawn
  @@ (Pawn.generate_moves start_pos Black)

let test_pawn_move_invariant _ =
  assert_equal true
  @@ (Pawn.generate_moves start_pos White
     |> List.for_all ~f:(fun end_pos -> Pawn.can_move start_pos end_pos White))

let test_bishop_can_move _ =
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Bishop.can_move start_pos end_pos White)
       end_pos_diag_positive;
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Bishop.can_move start_pos end_pos White)
       end_pos_diag_negative

let test_bishop_generate_moves _ = assert_equal true true

let test_bishop_move_invariant _ =
  assert_equal true
  @@ (Bishop.generate_moves start_pos White
     |> List.for_all ~f:(fun end_pos -> Bishop.can_move start_pos end_pos White)
     )

let test_knight_can_move _ =
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Knight.can_move start_pos end_pos White)
       end_pos_knight

let test_knight_generate_moves _ = assert_equal true true

let test_knight_move_invariant _ =
  assert_equal true
  @@ (Knight.generate_moves start_pos White
     |> List.for_all ~f:(fun end_pos -> Knight.can_move start_pos end_pos White)
     )

let test_rook_can_move _ =
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Rook.can_move start_pos end_pos White)
       end_pos_horiz;
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Rook.can_move start_pos end_pos White)
       end_pos_vert

let test_rook_generate_moves _ = 
  assert_equal (end_pos_horiz @ end_pos_vert)
  @@ Rook.generate_moves start_pos White

let test_rook_move_invariant _ =
  assert_equal true
  @@ (Rook.generate_moves start_pos White
     |> List.for_all ~f:(fun end_pos -> Rook.can_move start_pos end_pos White))

let test_queen_can_move _ =
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Queen.can_move start_pos end_pos White)
       end_pos_diag_positive;
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Queen.can_move start_pos end_pos White)
       end_pos_diag_negative;
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Queen.can_move start_pos end_pos White)
       end_pos_horiz;
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> Queen.can_move start_pos end_pos White)
       end_pos_vert

let test_queen_generate_moves _ = assert_equal true true

let test_queen_move_invariant _ =
  assert_equal true
  @@ (Queen.generate_moves start_pos White
     |> List.for_all ~f:(fun end_pos -> Queen.can_move start_pos end_pos White)
     )

let test_king_can_move _ =
  assert_equal true
  @@ List.for_all
       ~f:(fun end_pos -> King.can_move start_pos end_pos White)
       end_pos_king

let test_king_generate_moves _ = assert_equal true true

let test_king_move_invariant _ =
  assert_equal true
  @@ (King.generate_moves start_pos White
     |> List.for_all ~f:(fun end_pos -> King.can_move start_pos end_pos White))

let piece_tests =
  "piece tests"
  >: test_list
       [
         "test_in_bounds" >:: test_in_bounds;
         "test_out_bounds_x1" >:: test_out_bounds_x1;
         "test_out_bounds_x2" >:: test_out_bounds_x2;
         "test_out_bounds_y1" >:: test_out_bounds_y1;
         "test_out_bounds_y2" >:: test_out_bounds_y2;
         "test_pawn_can_move" >:: test_pawn_can_move;
         "test_pawn_generate_moves" >:: test_pawn_generate_moves;
         "test_pawn_move_invariant" >:: test_pawn_move_invariant;
         "test_bishop_can_move" >:: test_bishop_can_move;
         (* "test_bishop_generate_moves" >:: test_bishop_generate_moves; *)
         "test_bishop_move_invariant" >:: test_bishop_move_invariant;
         "test_knight_can_move" >:: test_knight_can_move;
         (* "test_knight_generate_moves" >:: test_knight_generate_moves; *)
         "test_knight_move_invariant" >:: test_knight_move_invariant;
         "test_rook_can_move" >:: test_rook_can_move;
         "test_rook_generate_moves" >:: test_rook_generate_moves;
         "test_rook_move_invariant" >:: test_rook_move_invariant;
         "test_queen_can_move" >:: test_queen_can_move;
         (* "test_queen_generate_moves" >:: test_queen_generate_moves; *)
         "test_queen_move_invariant" >:: test_queen_move_invariant;
         (* "test_king_can_move" >:: test_king_can_move; *)
         (* "test_king_generate_moves" >:: test_king_generate_moves; *)
         (* "test_king_move_invariant" >:: test_king_move_invariant; *)
       ]

let board_tests = "board tests" >: test_list []
let series = "chess tests" >::: [ piece_tests; board_tests ]
let () = run_test_tt_main series
