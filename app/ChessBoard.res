@react.component
let make = () => {
  let letters = ["a", "b", "c", "d", "e", "f", "g", "h"]

  let renderSquare = (row, col) => {
    let squareContent = switch (row, col) {
    | (1, col) => <div className="row-1"> {React.string(col->string_of_int)} </div>
    | (row, 1) => <div className="col-1"> {React.string(letters[row - 1])} </div>
    | _ => React.null
    }

    <div className="square"> {squareContent} </div>
  }

  let getRowClass = row => {
    if mod(row, 2) == 0 {
      "even-row"
    } else {
      "odd-row"
    }
  }

  let renderRow = row => {
    let rowClass = getRowClass(row)
    <div className={"chess-row " ++ rowClass}>
      {Array.init(8, col => renderSquare(row, col + 1))->React.array}
    </div>
  }
  <div id="chess-board"> {Array.init(8, row => renderRow(row + 1))->React.array} </div>
}
