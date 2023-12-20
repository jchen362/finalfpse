open Core
open OUnit2
open Board
open Lib
open Chess_ai

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
  [ { x = 5; y = 2 }; { x = 3; y = 2 }; { x = 4; y = 2 }; { x = 4; y = 3 } ]

let end_pos_black_pawn =
  [ { x = 5; y = 5 }; { x = 3; y = 5 }; { x = 4; y = 5 } ]

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
  @@ Pawn.generate_moves default_pos_black_pawn Black;
  assert_equal end_pos_black_pawn @@ Pawn.generate_moves start_pos Black

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
         "test_bishop_generate_moves" >:: test_bishop_generate_moves;
         "test_bishop_move_invariant" >:: test_bishop_move_invariant;
         "test_knight_can_move" >:: test_knight_can_move;
         "test_knight_generate_moves" >:: test_knight_generate_moves;
         "test_knight_move_invariant" >:: test_knight_move_invariant;
         "test_rook_can_move" >:: test_rook_can_move;
         "test_rook_generate_moves" >:: test_rook_generate_moves;
         "test_rook_move_invariant" >:: test_rook_move_invariant;
         "test_queen_can_move" >:: test_queen_can_move;
         "test_queen_generate_moves" >:: test_queen_generate_moves;
         "test_queen_move_invariant" >:: test_queen_move_invariant;
         "test_king_can_move" >:: test_king_can_move;
         "test_king_generate_moves" >:: test_king_generate_moves;
         "test_king_move_invariant" >:: test_king_move_invariant;
       ]

let default_board = Board_state.default_board

(* let default_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
   let e4_fen = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1" *)
let default_fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
let e4_fen = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR"

let test_board_state_empty _ =
  match default_fen |> Board_state.import with
  | None -> assert_failure "board state import and export failed"
  | Some board -> assert_equal default_fen @@ Board_state.export board

let test_board_state_e4 _ =
  match e4_fen |> Board_state.import with
  | None -> assert_failure "board state import and export failed"
  | Some board -> assert_equal e4_fen @@ Board_state.export board

let test_empty_fen_import _ = (
  assert_equal None ("" |> Board_state.import);
  assert_equal None (" " |> Board_state.import);
  assert_equal None ("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKB@R" |> Board_state.import);
  assert_equal None ("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR/AB" |> Board_state.import)
)
let board_io_tests =
  "board io tests"
  >: test_list
       [
         "test_board_state_empty" >:: test_board_state_empty;
         "test_board_state_e4" >:: test_board_state_e4;
         "test_empty_fen_import" >:: test_empty_fen_import;
       ]

let default_white_pawn_2 = { x = 1; y = 6 }
let default_white_left_rook = { x = 0; y = 7 }
let default_white_left_knight = { x = 1; y = 7 }
let default_white_left_bishop = { x = 2; y = 7 }
let default_white_queen = { x = 3; y = 7 }
let default_white_king = { x = 4; y = 7 }

let default_while_pawn_2_valid_moves_ls =
  [
    { start = { x = 1; y = 6 }; dest = { x = 1; y = 4 } };
    { start = { x = 1; y = 6 }; dest = { x = 1; y = 5 } };
  ]

let test_valid_move_pawn _ =
  assert_equal false
  @@ Board_state.valid_move default_board default_white_pawn_2 { x = 2; y = 5 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_pawn_2 { x = 0; y = 5 };
  assert_equal true
  @@ Board_state.valid_move default_board default_white_pawn_2 { x = 1; y = 5 };
  assert_equal true
  @@ Board_state.valid_move default_board default_white_pawn_2 { x = 1; y = 4 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_pawn_2 { x = 2; y = 6 }

let test_valid_move_rook _ =
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_rook
       { x = 1; y = 7 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_rook
       { x = 2; y = 7 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_rook
       { x = 0; y = 6 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_rook
       { x = 0; y = 5 }

let test_valid_move_knight _ =
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_knight
       { x = 3; y = 6 };
  assert_equal true
  @@ Board_state.valid_move default_board default_white_left_knight
       { x = 2; y = 5 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_knight
       { x = 4; y = 7 }

let test_valid_move_bishop _ =
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_bishop
       { x = 3; y = 6 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_bishop
       { x = 4; y = 5 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_bishop
    { x = 3; y = 6 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_bishop
    { x = 2; y = 5 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_left_bishop
    { x = 4; y = 7 }


let test_valid_move_queen _ =
  assert_equal false
  @@ Board_state.valid_move default_board default_white_queen { x = 3; y = 4 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_queen { x = 1; y = 7 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_queen { x = 1; y = 5 }

let test_valid_move_king _ =
  assert_equal false
  @@ Board_state.valid_move default_board default_white_king { x = 3; y = 7 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_king { x = 5; y = 7 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_king { x = 4; y = 6 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_king { x = 3; y = 6 };
  assert_equal false
  @@ Board_state.valid_move default_board default_white_king { x = 5; y = 6 }

let test_valid_moves_ls_pawn _ =
  assert_equal default_while_pawn_2_valid_moves_ls
  @@ Board_state.valid_moves_piece default_board default_white_pawn_2

let test_valid_move_rook _ =
  assert_equal []
  @@ Board_state.valid_moves_piece default_board default_white_left_rook

let test_valid_move_out_bounds _ =
  assert_equal false
  @@ Board_state.valid_move default_board {x = 4; y = 4} {x = 4; y = 5};
  assert_equal false
  @@ Board_state.valid_move default_board {x = 1; y = 0} {x = 1; y = 0}

let int_gen = Int.gen_incl (-1000) 1000
let random_x_pos = Quickcheck.random_value int_gen
let random_y_pos = Quickcheck.random_value int_gen

let test_valid_moves_piece _ =
  assert_equal
    (Board_state.valid_moves_piece default_board default_white_king
    |> List.length)
    0;
  assert_equal
    (Board_state.valid_moves_piece default_board default_white_pawn_2
    |> List.length)
    2;
  assert_equal
    (Board_state.valid_moves_piece default_board default_white_left_knight
    |> List.length)
    2;
  assert_equal
    (Board_state.valid_moves_piece default_board default_white_left_rook
    |> List.length)
    0;
  assert_equal
    (Board_state.valid_moves_piece default_board default_white_left_bishop
    |> List.length)
    0;
  assert_equal
    (Board_state.valid_moves_piece default_board default_white_queen
    |> List.length)
    0;
  assert_equal
    (Board_state.valid_moves_piece default_board { x = 4; y = 4 } |> List.length)
    0;
  assert_equal
    (Board_state.valid_moves_piece default_board
       { x = random_x_pos; y = random_x_pos }
    |> List.length >= 0)
    true

let test_board_move _ =
  (*Move pawn forward by 1*)
  assert_equal
    (Board_state.move
       (Board_state.import "3k4/8/8/8/8/8/3P4/3K4" |> Option.value_exn)
       { x = 3; y = 6 } { x = 3; y = 5 }
    |> Board_state.export)
    "3k4/8/8/8/8/3P4/8/3K4";
  (*Invalid movement out of bounds*)
  assert_equal
    (Board_state.move
       (Board_state.import "3k4/8/8/8/8/8/3P4/3K4" |> Option.value_exn)
       { x = 3; y = 6 } { x = 3; y = -5 }
    |> Board_state.export)
    "3k4/8/8/8/8/8/3P4/3K4";
  (*Pawn promotion*)
  assert_equal
    (Board_state.move
       (Board_state.import "3k4/7P/8/8/8/8/8/3K4" |> Option.value_exn)
       { x = 7; y = 1 } { x = 7; y = 0 }
    |> Board_state.export)
    "3k3Q/8/8/8/8/8/8/3K4"

let test_check _ =
  assert_equal (Board_state.in_check default_board Black) false;
  assert_equal (Board_state.in_check default_board White) false;
  (*Queen trying to capture king, but knight can block*)
  assert_equal
    (Board_state.in_check
       ("rnb1kbnr/pppp1ppp/3Q4/4p3/4q3/8/PPPP1PPP/RNB1KBNR"
      |> Board_state.import |> Option.value_exn)
       White)
    true;
  (*Two rooks putting black king in checkmate*)
  assert_equal
    (Board_state.in_check
       ("k7/8/8/8/8/8/RR6/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    true;
  assert_equal
    (Board_state.in_check
       ("k7/8/8/8/8/8/RR6/3K4" |> Board_state.import |> Option.value_exn)
       White)
    false;
  (*Black king in corner with knight checking it checkmate*)
  assert_equal
    (Board_state.in_check
       ("k7/1RR5/1N6/8/8/8/8/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    true;
  assert_equal
    (Board_state.in_check
       ("k7/1RR5/1N6/8/8/8/8/3K4" |> Board_state.import |> Option.value_exn)
       White)
    false;
  (*Black king checked by bishop but not in checkmate*)
  assert_equal
    (Board_state.in_check
       ("k7/6R1/8/3B4/8/8/8/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    true;
  (*Black king checked by pawn but not in checkmate*)
  assert_equal
    (Board_state.in_check
       ("k7/1P4R1/8/8/8/8/8/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    true;
  (*White King in checkmate by black pawn*)
  assert_equal
    (Board_state.in_check
       ("3kr3/8/8/8/8/2p5/rpp5/3K4" |> Board_state.import |> Option.value_exn)
       White)
    true;

  (*White King in checkmate by black knight*)
  assert_equal
    (Board_state.in_check
       ("3kr3/8/8/8/8/1pp5/rp3n2/3K4" |> Board_state.import |> Option.value_exn)
       White)
    true;

  (*White King in checkmate by black rook*)
  assert_equal
    (Board_state.in_check
       ("3kr3/8/8/8/8/1pp5/rp6/3K3r" |> Board_state.import |> Option.value_exn)
       White)
    true;

  (*White King in checkmate by black bishop*)
  assert_equal
    (Board_state.in_check
       ("3kr3/8/8/7b/8/1pp5/rp6/3K4" |> Board_state.import |> Option.value_exn)
       White)
    true;

  (*Black King in check and checkmate surrounded by black pieces white bishop checking it*)
  assert_equal
    (Board_state.in_check
       ("kr6/pnN5/8/8/8/8/8/K7" |> Board_state.import |> Option.value_exn)
       Black)
    true

let test_checkmate _ =
  assert_equal (Board_state.in_checkmate default_board Black) false;
  assert_equal (Board_state.in_checkmate default_board White) false;
  (*Queen trying to capture king, but knight can block*)
  assert_equal
    (Board_state.in_checkmate
       ("rnb1kbnr/pppp1ppp/3Q4/4p3/4q3/8/PPPP1PPP/RNB1KBNR"
      |> Board_state.import |> Option.value_exn)
       White)
    false;
  (*Two rooks putting black king in checkmate*)
  assert_equal
    (Board_state.in_checkmate
       ("k7/8/8/8/8/8/RR6/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    true;
  assert_equal
    (Board_state.in_checkmate
       ("k7/8/8/8/8/8/RR6/3K4" |> Board_state.import |> Option.value_exn)
       White)
    false;
  (*Black king in corner with knight checking it checkmate*)
  assert_equal
    (Board_state.in_checkmate
       ("k7/1RR5/1N6/8/8/8/8/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    true;
  assert_equal
    (Board_state.in_checkmate
       ("k7/1RR5/1N6/8/8/8/8/3K4" |> Board_state.import |> Option.value_exn)
       White)
    false;
  (*White King in checkmate by black pawn*)
  assert_equal
    (Board_state.in_check
       ("3kr3/8/8/8/8/1pp5/rpp5/3K4" |> Board_state.import |> Option.value_exn)
       White)
    true;

  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/8/8/1pp5/rpp5/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    false;

  (*White King in checkmate by black knight*)
  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/8/8/1pp5/rp3n2/3K4" |> Board_state.import |> Option.value_exn)
       White)
    true;

  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/8/8/1pp5/rp3n2/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    false;

  (*White King in checkmate by black rook*)
  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/8/8/1pp5/rp6/3K3r" |> Board_state.import |> Option.value_exn)
       White)
    true;

  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/8/8/1pp5/rp6/3K3r" |> Board_state.import |> Option.value_exn)
       Black)
    false;

  (*White King in checkmate by black bishop*)
  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/7b/8/1pp5/rp6/3K4" |> Board_state.import |> Option.value_exn)
       White)
    true;

  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/7b/8/1pp5/rp6/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    false;

  (*White king surrounded by pawns, not in checkmate so should be in stalemate*)
  assert_equal
    (Board_state.in_checkmate
       ("3kr3/8/8/8/8/1pp5/rp6/3K4" |> Board_state.import |> Option.value_exn)
       White)
    false;

  (*Black King in check and checkmate surrounded by black pieces white bishop checking it*)
  assert_equal
    (Board_state.in_checkmate
       ("kr6/pnN5/8/8/8/8/8/K7" |> Board_state.import |> Option.value_exn)
       Black)
    true

let test_stalemate _ =
  assert_equal (Board_state.in_stalemate default_board Black) false;
  assert_equal (Board_state.in_stalemate default_board White) false;

  (*White king surrounded by pawns*)
  assert_equal
    (Board_state.in_stalemate
       ("3kr3/8/8/8/8/1pp5/rp6/3K4" |> Board_state.import |> Option.value_exn)
       White)
    true;

  (*White King in checkmate by black bishop, should not be in stalemate*)
  assert_equal
    (Board_state.in_stalemate
       ("3kr3/8/8/7b/8/1pp5/rp6/3K4" |> Board_state.import |> Option.value_exn)
       White)
    false;

  (*Black king checked by bishop but not in checkmate, should not be in stalemate*)
  assert_equal
    (Board_state.in_stalemate
       ("k7/6R1/8/3B4/8/8/8/3K4" |> Board_state.import |> Option.value_exn)
       Black)
    false;

  (*White King trapped by two black rooks, not in check but in stalemate*)
  assert_equal
    (Board_state.in_stalemate
       ("3kr3/8/8/1r6/8/8/7r/K7" |> Board_state.import |> Option.value_exn)
       White)
    true;
  assert_equal
    (Board_state.in_stalemate
       ("3kr3/8/8/1r6/8/8/7r/K7" |> Board_state.import |> Option.value_exn)
       Black)
    false;
  (*White King trapped by pawn, rook, and knight, not in check but in stalemate*)
  assert_equal
    (Board_state.in_stalemate
       ("3kr3/8/8/8/8/1pn5/7r/K7" |> Board_state.import |> Option.value_exn)
       White)
    true;
  assert_equal
    (Board_state.in_stalemate
       ("3kr3/8/8/8/8/1pn5/7r/K7" |> Board_state.import |> Option.value_exn)
       Black)
    false;
  (*Black King trapped by knight and queen, not in check but in stalemate*)
  assert_equal
    (Board_state.in_stalemate
       ("k7/7Q/2N5/8/8/8/8/K7" |> Board_state.import |> Option.value_exn)
       White)
    false;
  assert_equal
    (Board_state.in_stalemate
       ("k7/7Q/2N5/8/8/8/8/K7" |> Board_state.import |> Option.value_exn)
       Black)
    true

let board_tests =
  "board tests"
  >: test_list
       [
         "test_valid_move_pawn" >:: test_valid_move_pawn;
         "test_valid_move_rook" >:: test_valid_move_rook;
         "test_valid_move_knight" >:: test_valid_move_knight;
         "test_valid_move_bishop" >:: test_valid_move_bishop;
         "test_valid_move_queen" >:: test_valid_move_queen;
         "test_valid_move_king" >:: test_valid_move_king;
         "test_valid_moves_ls_pawn" >:: test_valid_moves_ls_pawn;
         "test_valid_move_rook" >:: test_valid_move_rook;
         "test_valid_moves_piece" >:: test_valid_moves_piece;
         "test_valid_invalid_moves" >:: test_valid_move_out_bounds;
         "test_board_move" >:: test_board_move;
         "test_check" >:: test_check;
         "test_checkmate" >:: test_checkmate;
         "test_stalemate" >:: test_stalemate;
       ]

let test_evaluation _ =
  assert_equal 0.0 @@ Eval.evaluate Board_state.default_board Lib.White

let arabian_mate_fen = "7k/7R/5N2/8/8/8/8/8"
let anastasias_mate_fen = "8/4N1pk/8/7R/8/8/8/8"
let one_valid_move = "7k/3n1KRP/6P1/8/8/8/8/4r3"
let post_valid_move = "6Rk/3n1K1P/6P1/8/8/8/8/4r3"

let test_generate_next_move _ =
  assert_equal arabian_mate_fen
  @@ Minimax.generate_next_move arabian_mate_fen 'B' 1;
  assert_equal anastasias_mate_fen
  @@ Minimax.generate_next_move anastasias_mate_fen 'B' 1;
  assert_equal post_valid_move
  @@ Minimax.generate_next_move one_valid_move 'W' 1;
  assert_equal "k6R/6R1/8/8/8/8/8/2K5"
  @@ Minimax.generate_next_move "k7/6R1/8/8/8/8/8/2K4R" 'W' 1

let chess_ai_tests =
  "chess ai tests"
  >: test_list
       [
         "test_evaluation" >:: test_evaluation;
         "test_generate_next_move" >:: test_generate_next_move;
       ]

let series =
  "chess tests"
  >::: [ piece_tests; board_io_tests; board_tests; chess_ai_tests ]

let () = run_test_tt_main series
