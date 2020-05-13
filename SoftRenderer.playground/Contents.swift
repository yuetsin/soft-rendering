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

for fragment in generateCube(basePoint: Vector3d(1, 0, 0), size: 3) {
    canvas.addObject(object: fragment)
}

for line in generateRefrenceLines(distance: 0.5, count: 5) {
    canvas.addObject(object: line)
}

for line in generateAxis(length: 3) {
    canvas.addObject(object: line)
}

//: render it
canvas.render()
