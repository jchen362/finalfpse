@react.component
let make = () => {
  let (fenBoard, setFenBoard) = React.useState(() => "")
  let (colorSelection, setColorSelection) = React.useState(() => "")
  let (difficultySelection, setDifficultySelection) = React.useState(() => "")
  let (nextFenBoard, setNextFenBoard) = React.useState(() => "")
  let (isSubmitted, setIsSubmitted) = React.useState(() => false)

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
  // setColorSelection(_ => "White")
  // setDifficultySelection(_ => "1")

  let handleSubmit = event => {
    ReactEvent.Form.preventDefault(event)

    // GET endpoint on server
    let endpoint = "http://localhost:8080/get_suggested_move?"

    // Query parameters
    let queryString =
      "board=" ++
      fenBoard ++
      "&color=" ++
      Js.Global.encodeURIComponent("W") ++
      "&difficulty=" ++
      Js.Global.encodeURIComponent("1")
    // "board=" ++
    // Js.Global.encodeURIComponent(fenBoard) ++
    // "&color=" ++
    // Js.Global.encodeURIComponent(colorSelection) ++
    // "&difficulty=" ++
    // Js.Global.encodeURIComponent(difficultySelection)

    // let nextMoveJson = Js.Obj.empty
    // Js.Obj.set

    setIsSubmitted(_ => true)
    setNextFenBoard(_ => "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR")
    Js.log(endpoint ++ queryString)
    let getMove = async (query: string) => {
      Js.log("test")
      let response = await Fetch.get(query)
      Js.log("test2")
      let json = await response->Fetch.Response.json
      setNextFenBoard(_ => json->Js.Json.stringify)
      Js.log(Js.Json.stringify(json))
    }
    let move = getMove(endpoint ++ queryString)
    Js.log(move)
    // Js.log(getMove)
  }
  <div>
    <form onSubmit={handleSubmit}>
      <div className="flex items-center space-x-4">
        <input
          className="border-2 border-gray-300 bg-white h-10 px-5 py-2 w-96 rounded-lg text-sm focus:outline-none"
          value={fenBoard}
          onChange={event => setFenBoard(ReactEvent.Form.currentTarget(event)["value"])}
          type_="text"
          placeholder="FEN board"
        />
        <Dropdown
          items=colorDropdownItems
          placeholder="Select a color"
          // onSelect={setColorSelection}
        />
        <Dropdown
          items=difficultyDropdownItems
          placeholder="Select a difficulty"
          // onSelect={setDifficultySelection}
        />
      </div>
      <button
        type_="submit"
        className="mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        {React.string("Submit")}
      </button>
    </form>
    {isSubmitted
      ? <div className="flex py-5">
          <img className="h-96 w-96" src={"https://fen2image.chessvision.ai/" ++ fenBoard} />
          <img className="h-96 w-48" src={"./arrow.svg"} />
          <img className="h-96 w-96" src={"https://fen2image.chessvision.ai/" ++ nextFenBoard} />
        </div>
      : React.null}
  </div>
}
