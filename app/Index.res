open Webapi.Dom

module Client = {
  module Root = {
    type t

    @send external render: (t, React.element) => unit = "render"

    @send external unmount: (t, unit) => unit = "unmount"
  }

  @module("react-dom/client")
  external createRoot: Dom.element => Root.t = "createRoot"

  @module("react-dom/client")
  external hydrateRoot: (Dom.element, React.element) => Root.t = "hydrateRoot"
}

let rootElement = document->Document.getElementById("root")
switch rootElement {
| Some(element) =>
  let root = Client.createRoot(element)
  root->Client.Root.render(<Test />)
| None => Js.log("Root element not found")
}
