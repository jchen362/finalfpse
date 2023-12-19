// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as JsxRuntime from "react/jsx-runtime";

function Dropdown(props) {
  var placeholder = props.placeholder;
  var placeholder$1 = placeholder !== undefined ? placeholder : "Select an option";
  var match = React.useState(function () {
        return false;
      });
  var setIsOpen = match[1];
  var match$1 = React.useState(function () {
        return "";
      });
  var setSelectedItemText = match$1[1];
  var selectedItemText = match$1[0];
  var dropdownPlaceholder = selectedItemText === "" ? placeholder$1 : selectedItemText;
  var dropdownClass = match[0] ? "block" : "hidden";
  return JsxRuntime.jsxs("div", {
              children: [
                JsxRuntime.jsx("button", {
                      children: dropdownPlaceholder,
                      className: "text-left border-2 border-gray-300 bg-white h-10 px-5 w-48 rounded-lg text-sm focus:outline-none",
                      onClick: (function (_event) {
                          Curry._1(setIsOpen, (function (prevIsOpen) {
                                  return !prevIsOpen;
                                }));
                        })
                    }),
                JsxRuntime.jsx("div", {
                      children: Belt_Array.map(props.items, (function (item) {
                              return JsxRuntime.jsx("a", {
                                          children: item.text,
                                          className: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100",
                                          onClick: (function (_event) {
                                              var text = item.text;
                                              Curry._1(setSelectedItemText, (function (param) {
                                                      return text;
                                                    }));
                                              Curry._1(setIsOpen, (function (param) {
                                                      return false;
                                                    }));
                                            })
                                        }, item.id);
                            })),
                      className: "absolute mt-1 py-2 w-48 border-gray-300 bg-white rounded-md shadow-xl z-10 " + dropdownClass
                    })
              ],
              className: "relative pl-3"
            });
}

var make = Dropdown;

export {
  make ,
}
/* react Not a pure module */
