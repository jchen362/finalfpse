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
                        "), the color to move (white or black), and the AI difficulty level (1 to 3)."
                      ]
                    }),
                JsxRuntime.jsx("br", {}),
                JsxRuntime.jsx("h2", {
                      children: "Sample boards:",
                      className: "text-xl font-semibold"
                    }),
                JsxRuntime.jsx("p", {
                      children: "Default board: rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR (White to move)"
                    }),
                JsxRuntime.jsx("p", {
                      children: "Board with one possible move: 7k/3n1KRP/6P1/8/8/8/8/4r3 (White to move)"
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
