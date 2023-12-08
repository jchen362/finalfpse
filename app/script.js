document.addEventListener('DOMContentLoaded', function () {
  const chessBoard = document.getElementById('chess-board');
  const letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];

  for (let row = 1; row <= 8; row++) {
    const rowDiv = document.createElement('div');
    rowDiv.classList.add('chess-row');
    rowDiv.classList.add(row % 2 === 0 ? 'even-row' : 'odd-row');

    for (let col = 1; col <= 8; col++) {
      const square = document.createElement('div');
      square.classList.add('square');

      if (row === 1) {
        const cnotation = document.createElement('div');
        cnotation.classList.add('row-1')
        cnotation.textContent = col;
        square.appendChild(cnotation);
      }
      if (col === 1) {
        const rnotation = document.createElement('div');
        rnotation.classList.add('col-1')
        rnotation.textContent = letters[row - 1];
        square.appendChild(rnotation);
      }

      rowDiv.appendChild(square);
    }

    chessBoard.appendChild(rowDiv);
  }
});