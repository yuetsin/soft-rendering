import Cocoa
import PlaygroundSupport

let canvasSize = CGSize(width: 250, height: 300)
//: initialize a `SRCanvas`
var canvas = SRCanvas(size: canvasSize, color: CIColor.clear)

//: activate current live view
PlaygroundPage.current.liveView = canvas

//: define `Object2DDrawable` objects
let line = Line2D(beginPoint: Point2d(x: 30, y: 30),
                endPoint: Point2d(x: 100, y: 120), color: CIColor.red, endColor: CIColor.blue)
let triangle = Triangle(pointA: Point2d(x: 0, y: 0),
                        pointB: Point2d(x: 100, y: 30),
                        pointC: Point2d(x: 50, y: 140),
                        colorA: CIColor.yellow,
                        colorB: CIColor.cyan,
                        colorC: CIColor.magenta)
//: put them on the canvas
canvas.addObject(object: triangle)
canvas.addObject(object: line)

for _ in 0 ..< 100 {
    let line = Line3D(beginPoint: randomPoint3d(size: canvasSize),
                      endPoint: randomPoint3d(size: canvasSize),
                      color: randomCIColor(), endColor: randomCIColor())
    canvas.addObject(object: line)
}

//: render it
canvas.render()
