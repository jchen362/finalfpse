open Core
open Chess_ai

let str_opt_to_char (str_opt : string option) : char option =
  match str_opt with
  | None -> None
  | Some str -> (
      match String.to_list str with
      | ch :: _ -> Some (Char.uppercase ch)
      | [] -> None)

let decode_uri_opt (str_opt : string option) : string option =
  match str_opt with None -> None | Some str -> Some (Uri.pct_decode str)

let get_suggested_move : Dream.route =
  Dream.get "/get_suggested_move" (fun request ->
      let board = Dream.query request "board" in
      let color = Dream.query request "color" in
      let difficulty = Dream.query request "difficulty" in
      match (decode_uri_opt board, str_opt_to_char color, difficulty) with
      | Some board, Some to_move, Some difficulty ->
          Dream.json ~status:`OK
            ~headers:[ ("Access-Control-Allow-Origin", "*") ]
            (Minimax.generate_next_move board to_move (int_of_string difficulty))
      | Some _, Some _, None ->
          Dream.json ~status:`Bad_Request
            ~headers:[ ("Access-Control-Allow-Origin", "*") ]
            "Invalid difficulty"
      | Some _, None, _ ->
          Dream.json ~status:`Bad_Request
            ~headers:[ ("Access-Control-Allow-Origin", "*") ]
            "Invalid color"
      | None, _, _ ->
          Dream.json ~status:`Bad_Request
            ~headers:[ ("Access-Control-Allow-Origin", "*") ]
            "Invalid board")

let () =
  Dream.run @@ Dream.logger @@ Dream.memory_sessions
  @@ Dream.router [ get_suggested_move ]
