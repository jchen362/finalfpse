open Core
open OUnit2
open Lib

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

let test_pawn _ = assert_equal true true
let test_bishop _ = assert_equal true true
let test_knight _ = assert_equal true true
let test_rook _ = assert_equal true true
let test_queen _ = assert_equal true true
let test_king _ = assert_equal true true

let piece_tests =
  "piece tests"
  >: test_list
       [
         "test_in_bounds" >:: test_in_bounds;
         "test_out_bounds_x1" >:: test_out_bounds_x1;
         "test_out_bounds_x2" >:: test_out_bounds_x2;
         "test_out_bounds_y1" >:: test_out_bounds_y1;
         "test_out_bounds_y2" >:: test_out_bounds_y2;
         "test_pawn" >:: test_pawn;
         "test_bishop" >:: test_bishop;
         "test_knight" >:: test_knight;
         "test_rook" >:: test_rook;
         "test_queen" >:: test_queen;
         "test_king" >:: test_king;
       ]

let board_tests = "board tests" >: test_list []
let series = "chess tests" >::: [ piece_tests; board_tests ]
let () = run_test_tt_main series
