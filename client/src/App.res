@react.component
let make = () => {
  let fenLink = "https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation"
  let colorDropdownItems: array<Dropdown.dropdownItem> = [
    {id: "1", text: "White"},
    {id: "2", text: "Black"},
  ]
  let difficultyDropdownItems: array<Dropdown.dropdownItem> = [
    {id: "1", text: "1"},
    {id: "2", text: "2"},
    {id: "3", text: "3"},
    {id: "4", text: "4"},
    {id: "5", text: "5"},
  ]

  <div className="p-6">
    <h1 className="text-3xl font-semibold"> {"Chess Move Suggester"->React.string} </h1>
    <p>
      {React.string("Please input your current chessboard state (in ")}
      <a className="text-blue-600 hover:underline" href=fenLink> {React.string("FEN Format")} </a>
      {React.string("), the color to move (white or black), and the AI difficulty level (1 to 5).")}
    </p>
    <br />
    <p> {React.string("The default board is rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR.")} </p>
    <br />
    <div className="flex">
      <Form />
      // <Textbox placeholder="FEN board" />
      // <Dropdown items=colorDropdownItems placeholder="Select a color" />
      // <Dropdown items=difficultyDropdownItems placeholder="Select a difficulty" />
    </div>
    <br />
  </div>
}
