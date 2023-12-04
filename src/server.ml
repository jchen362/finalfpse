(* open Core

let home _ =
  Dream.html
    (Dream.page "Chess Board"
       ~meta:[ Dream.head_link ~rel:`Stylesheet ~href:"/styles.css" () ]
       (Dream.body
          [ Dream.h1 [ Dream.txt "Chess Board" ];
            Dream.p [ Dream.txt "Your chess board goes here." ] ]))

let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router
       [ Dream.get "/" home ] *)
