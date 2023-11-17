# Chess AI
Authors: Jianwei Chen (jchen362), Sana Mahmood (smahmo12), Brandon Wong (bwong19)

# Libraries
Packages used in this project can be found in the `chess_ai.opam` file. To install them, run `opam install . --deps-only` in the root directory of the project. These packages include and are not limited to:
* Core
* Ounit2
* Dream
* Yojson
and their dependencies.

# Usage
To run the Chess AI, run the following commands to start the server:

```
dune build
dune exec ./src/server.exe
```

Now information can be retrieved based on the following API endpoints:

`/get-suggested-moves/{board}/{difficulty}`
* board: board state in FEN string format
* difficulty (optional): difficulty level of the AI. 1-5 (default: 5)
* return value: list of moves in string format (e.g. [Ke1, Nf4, a5])

`/get-move-evaluation/{board}/{move}`
* board: board state in FEN string format
* move: move in algebraic notation string format (e.g. Ke1)
* return value: float ranging from -n to n, where n is the maximum possible score

# Implementation Order
The order we plan to implement our Chess AI is as follows:
1. Piece (`lib.ml`)
2. Board (`lib.ml`)
3. Evaluation (`chess_ai.ml`)
4. Move Generation (`chess_ai.ml`)
5. Endpoint functions (`server_lib.ml`)
6. Server (`server.ml`)
7. Other features if time permits, such as playing a full game, web UI, etc.

Testing will be added incrementally in `tests.ml`.