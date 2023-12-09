(* let () =
  Dream.run @@ Dream.logger
  @@ Dream.router
       [
         Dream.get "/" (fun request ->
             Template.default_board request |> Dream.html);
         Dream.post "/" (fun request ->
             match%lwt Dream.form request with
             | `Ok [ ("my.field", _) ] ->
                 Template.default_board request |> Dream.html
             | _ -> Dream.empty `Bad_Request);
         Dream.get "/app/**" (Dream.static "./app");
       ] *)
(* @@ Dream.not_found *)


let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router [

    Dream.get  "/"
      (fun request ->
        Dream.html (Template.default_board request));

    Dream.post "/"
      (fun request ->
        match%lwt Dream.form request with
        | `Ok ["message", message] ->
          Dream.html (Template.default_board ~message request)
        | _ ->
          Dream.empty `Bad_Request);

    Dream.get "/app/**" (Dream.static "./app");

  ]