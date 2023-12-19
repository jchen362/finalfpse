@react.component
let make = () => {
  let (fenBoard, setFenBoard) = React.useState(() => "")
  let (colorSelection, setColorSelection) = React.useState(() => "")
  let (difficultySelection, setDifficultySelection) = React.useState(() => "")
  let (nextFenBoard, setNextFenBoard) = React.useState(() => "")
  let (isSubmitted, setIsSubmitted) = React.useState(() => false)

  // Set color dropdown
  let colorDropdownItems: array<Dropdown.dropdownItem> = [
    {id: "1", text: "White"},
    {id: "2", text: "Black"},
  ]
  // Set difficulty dropdown
  let difficultyDropdownItems: array<Dropdown.dropdownItem> = [
    {id: "1", text: "1"},
    {id: "2", text: "2"},
    {id: "3", text: "3"},
    {id: "4", text: "4"},
    {id: "5", text: "5"},
  ]

  // Upon submitting data, perform query
  let handleSubmit = event => {
    ReactEvent.Form.preventDefault(event)

    // GET endpoint on server
    let endpoint = "http://localhost:8080/get_suggested_move?"

    // Query parameters
    let queryString =
      "board=" ++
      Js.Global.encodeURIComponent(fenBoard) ++
      "&color=" ++
      Js.Global.encodeURIComponent(colorSelection) ++
      "&difficulty=" ++
      Js.Global.encodeURIComponent(difficultySelection)

    // Get move from server
    let getMove = async (query: string) => {
      let response = await Fetch.get(query)
      let text = await response->Fetch.Response.text
      setIsSubmitted(_ =>
        isSubmitted || (fenBoard != "" && colorSelection != "" && difficultySelection != "")
      )
      setNextFenBoard(_ => text)
    }
    Js.log(getMove(endpoint ++ queryString))
  }

  // Render form
  <div>
    <form onSubmit={handleSubmit}>
      <div className="flex items-center space-x-4">
        <Textbox value={fenBoard} onChange={setFenBoard} />
        <Dropdown
          items=colorDropdownItems placeholder="Select a color" onSelect={setColorSelection}
        />
        <Dropdown
          items=difficultyDropdownItems
          placeholder="Select a difficulty"
          onSelect={setDifficultySelection}
        />
      </div>
      <button
        type_="submit"
        className="mt-4 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
        {React.string("Submit")}
      </button>
    </form>
    // If the input has been submitted, render the output
    {isSubmitted
      ? <div>
          <div className="flex py-5">
            <img className="h-96 w-96" src={"https://fen2image.chessvision.ai/" ++ fenBoard} />
            <img className="h-96 w-48" src={"./arrow.svg"} />
            <img className="h-96 w-96" src={"https://fen2image.chessvision.ai/" ++ nextFenBoard} />
          </div>
          {React.string("The new FEN is " ++ nextFenBoard ++ ".")}
        </div>
      : React.null}
  </div>
}
