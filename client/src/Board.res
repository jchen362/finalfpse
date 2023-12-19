// // Define a component to fetch and display the image
// // Binding for JavaScript's fetch function and Response type
// @val external fetch: string => Js.Promise.t<Dom.response> = "fetch"
// @val external text: Dom.response => Js.Promise.t<string> = "text"

// // Function to fetch image from the API
// let fetchImage = () => {
//   fetch("https://fen2image.chessvision.ai/rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
//   ->Js.Promise.then_(res => text(res))
//   ->Js.Promise.then_(data => {
//     setImageSrc(_ => data) // Assuming the API returns a direct URL
//     Js.Promise.resolve()
//   })
//   ->Js.Promise.catch(_error => {
//     // Handle error
//     Js.Promise.resolve()
//   })
// }

// @react.component
// let make = () => {
//   let (imageSrc, setImageSrc) = React.useState(_ => "")

//   // Fetch the image when the component mounts
//   React.useEffect0(() => {
//     fetchImage()
//     None
//   })

//   <div>
//     {imageSrc != "" ? <img src=imageSrc /> : <div> {"Loading image..."->React.string} </div>}
//   </div>
// }

// // Use the component in your application
// ReactDOMRe.renderToElementWithId(<Board />, "root")
