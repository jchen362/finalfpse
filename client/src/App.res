@react.component
let make = () => {
  let fenLink = "https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation"

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"Chess Move Suggester"->React.string} </h1>
    <p>
      {React.string("Please input your current chessboard state (in ")}
      <a className="text-blue-600 hover:underline" href=fenLink> {React.string("FEN Format")} </a>
      {React.string("), the color to move (white or black), and the AI difficulty level (1 to 5).")}
    </p>
    <br />
    <p> {React.string("The default board is rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR.")} </p>
    <p> {React.string("Try this board: 5r2/8/1R6/ppk3p1/2N3P1/P4b2/1K6/5B2")} </p>
    <br />
    <div className="flex">
      <Form />
    </div>
    <br />
  </div>
}
