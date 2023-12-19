# Chess AI

Authors: Jianwei Chen (jchen362), Sana Mahmood (smahmo12), Brandon Wong (bwong19)

# Installation

## Backend

Packages used in this project can be found in the `chess_ai.opam` file. To install them, run `opam install . --deps-only` in the root directory of the project. These packages include and are not limited to:

- Core
- Ounit2
- Dream

and their dependencies.

## Frontend

The frontend is written in ReScript React with TailwindCSS and Vite.

To install the frontend dependencies, navigate to the frontend directory using `cd client`.

Install Node.js and npm from [here](https://nodejs.org/en). Install the dependencies using

```
npm install
```

# Usage

To run the Chess AI, run the following commands to start the server:

```
dune build
dune exec ./src/server.exe
```

The server will now be running on `localhost:8080`.

With the server running, information can be retrieved from the following API endpoint:

GET: `/get-suggested-move`

Parameters:

- board: board state in FEN string format
- color: color of the next move
- difficulty: difficulty level of the AI (1-5)

Return value: new board state in FEN string format

To view the frontend, navigate to the client directory using `cd client`.

Start the Rescript

# Implementation Order

The order we planned to implement our Chess AI is as follows:

1. Piece (`lib.ml`)
2. Board (`lib.ml`)
3. Evaluation (`chess_ai.ml`)
4. Move Generation (`chess_ai.ml`)
5. Endpoint functions (`server_lib.ml`)
6. Server (`server.ml`)
7. Other features if time permits, such as playing a full game, web UI, etc.

Testing will be added incrementally in `tests.ml`.
