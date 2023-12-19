@react.component
let make: (
  ~placeholder: string=?,
  ~value: string,
  ~onChange: (string => string) => unit,
) => React.element
