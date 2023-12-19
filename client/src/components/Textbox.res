// React component for textbox
@react.component
let make = (
  ~placeholder="Enter text here": string,
  ~value: string,
  ~onChange: (string => string) => unit,
) => {
  <input
    className="border-2 border-gray-300 bg-white h-10 px-5 py-2 w-96 rounded-lg text-sm focus:outline-none"
    value
    onChange={event => onChange(ReactEvent.Form.currentTarget(event)["value"])}
    type_="text"
    placeholder
  />
}
