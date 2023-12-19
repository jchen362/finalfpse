// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Form from "./components/Form.bs.mjs";
import * as JsxRuntime from "react/jsx-runtime";

function App(props) {
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsx("h1", {
                      children: "Chess Move Suggester",
                      className: "text-3xl font-semibold"
                    }),
                JsxRuntime.jsxs("p", {
                      children: [
                        "Please input your current chessboard state (in ",
                        JsxRuntime.jsx("a", {
                              children: "FEN Format",
                              className: "text-blue-600 hover:underline",
                              href: "https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation"
                            }),
                        "), the color to move (white or black), and the AI difficulty level (1 to 5)."
                      ]
                    }),
                JsxRuntime.jsx("br", {}),
                JsxRuntime.jsx("p", {
                      children: "The default board is rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR."
                    }),
                JsxRuntime.jsx("p", {
                      children: "Try this board: 5r2/8/1R6/ppk3p1/2N3P1/P4b2/1K6/5B2"
                    }),
                JsxRuntime.jsx("br", {}),
                JsxRuntime.jsx("div", {
                      children: JsxRuntime.jsx(Form.make, {}),
                      className: "flex"
                    }),
                JsxRuntime.jsx("br", {})
              ],
              className: "p-6"
            });
}

var make = App;

export {
  make ,
}
/* Form Not a pure module */
