open Core
open Chess_ai

let home : Dream.route =
  Dream.get "/" (fun request -> Dream.html (Template.default_board request))

let str_opt_to_char (str_opt : string option) : char option =
  match str_opt with
  | None -> None
  | Some str -> (
      match String.to_list str with
      | ch :: _ -> Some (Char.uppercase ch)
      | [] -> None)

let get_moves : Dream.route =
  Dream.get "/get_suggested_move" (fun request ->
      let board = Dream.query request "board" in
      let to_move = Dream.query request "to_move" in
      let difficulty = Dream.query request "difficulty" in
      match (board, str_opt_to_char to_move, difficulty) with
      | Some board, Some to_move, Some difficulty ->
          Dream.json ~status:`OK
            ~headers:[ ("Access-Control-Allow-Origin", "*") ]
            (Minimax.generate_next_move board to_move (int_of_string difficulty))
      | _ -> Dream.empty `Bad_Request)

let app : Dream.route = Dream.get "/app/**" (Dream.static "./app")

let () =
  Dream.run @@ Dream.logger @@ Dream.memory_sessions
  @@ Dream.router [ home; get_moves; app ]
