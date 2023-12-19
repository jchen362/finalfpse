type dropdownItem = {
  id: string,
  text: string,
}

@react.component
let make: (
  ~items: array<dropdownItem>,
  ~placeholder: string=?,
  ~onSelect: (string => string) => unit,
) => React.element
