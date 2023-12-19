@react.component
let make = () => {
  let fenLink = "https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation"

  <div className="p-6">
    // Header
    <h1 className="text-3xl font-semibold"> {"Chess Move Suggester"->React.string} </h1>
    <p>
      {React.string("Please input your current chessboard state (in ")}
      <a className="text-blue-600 hover:underline" href=fenLink> {React.string("FEN Format")} </a>
      {React.string("), the color to move (white or black), and the AI difficulty level (1 to 3).")}
    </p>
    <br />
    <h2 className="text-xl font-semibold"> {React.string("Sample boards:")} </h2>
    <p>
      {React.string("Default board: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR (White to move)")}
    </p>
    <p>
      {React.string("Board with one possible move: 7k/3n1KRP/6P1/8/8/8/8/4r3 (White to move)")}
    </p>
    <br />
    // Create form, most of the logic is in components/Form.res
    <div className="flex">
      <Form />
    </div>
    <br />
  </div>
}
