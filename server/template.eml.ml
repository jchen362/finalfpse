[@@@ocaml.warning "-27"]

let default_board ?message request =
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="stylesheet" href="app/style.css">
      <title>Chess Board</title>
  </head>
  <body>

  <div id="chess-board"></div>
  <br>
  <div id="fen_import">
  
    <form method="POST" action="/">
      <%s! Dream.csrf_tag request %>
      <input name="message" autofocus>
    </form>
  </div>

  <script type="module" src="app/script.js"></script>

  </body>
  </html>
