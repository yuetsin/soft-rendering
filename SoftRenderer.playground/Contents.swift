import Cocoa
import PlaygroundSupport

let canvasSize = CGSize(width: 400, height: 400)
//: initialize a `SRCanvas`
var canvas = SRCanvas(size: canvasSize, color: CIColor.clear)

//: activate current live view
PlaygroundPage.current.liveView = canvas

//: define `Object2DDrawable` objects
let line = Line2D(beginPoint: Vector2d(30, 30),
                  endPoint: Vector2d(100, 120), color: CIColor.red, endColor: CIColor.blue)
let fragment = Fragment2D(pointA: Vector2d(0, 0),
                          pointB: Vector2d(100, 30),
                          pointC: Vector2d(50, 140),
                        colorA: CIColor.yellow,
                        colorB: CIColor.cyan,
                        colorC: CIColor.magenta)





//: put them on the canvas
canvas.addObject(object: fragment)
canvas.addObject(object: line)
//
//for _ in 0 ..< 30 {
//    let fragment = Fragment3D(pointA: randomPoint3d(size: canvasSize),
//    pointB: randomPoint3d(size: canvasSize),
//    pointC: randomPoint3d(size: canvasSize),
//    colorA: randomCIColor())
//    canvas.addObject(object: fragment)
//}

//: render it
canvas.render()
