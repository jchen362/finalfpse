// React component for dropdown menu

type dropdownItem = {
  id: string,
  text: string,
}

@react.component
let make = (~items: array<dropdownItem>, ~placeholder="Select an option": string, ~onSelect) => {
  let (isOpen, setIsOpen) = React.useState(() => false)
  let (selectedItemText, setSelectedItemText) = React.useState(() => "")
  let dropdownPlaceholder = selectedItemText == "" ? placeholder : selectedItemText

  // Toggle dropdown setting
  let toggleDropdown = () => {
    setIsOpen(prevIsOpen => !prevIsOpen)
  }

  // Perform item selection actions
  let selectItem = text => {
    setSelectedItemText(_ => text)
    onSelect(_ => text)
    setIsOpen(_ => false)
  }

  // Set dropdown class based on open state
  let dropdownClass = isOpen ? "block" : "hidden"

  // Render dropdown menu
  <div className="relative pl-3">
    <button
      className="text-left border-2 border-gray-300 bg-white h-10 px-5 w-48 rounded-lg text-sm focus:outline-none"
      onClick={_event => toggleDropdown()}>
      {React.string(dropdownPlaceholder)}
    </button>
    <div
      className={"absolute mt-1 py-2 w-48 border-gray-300 bg-white rounded-md shadow-xl z-10 " ++
      dropdownClass}>
      // Render each selection item
      {items
      ->Belt.Array.map(item =>
        <a
          key={item.id}
          onClick={_event => selectItem(item.text)}
          className="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
          {React.string(item.text)}
        </a>
      )
      ->React.array}
    </div>
  </div>
}
