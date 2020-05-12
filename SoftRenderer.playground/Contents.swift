import Cocoa
import PlaygroundSupport

//: initialize a `SRCanvas`
var canvas = SRCanvas(size: CGSize(width: 250, height: 250), color: CIColor.clear)

PlaygroundPage.current.liveView = canvas

let line = Line(beginPoint: Point2d(x: 30, y: 30),
                endPoint: Point2d(x: 100, y: 120), color: CIColor.red, endColor: CIColor.blue)
let triangle = Triangle(pointA: Point2d(x: 0, y: 0),
                        pointB: Point2d(x: 100, y: 30),
                        pointC: Point2d(x: 50, y: 140),
                        colorA: CIColor.yellow,
                        colorB: CIColor.cyan,
                        colorC: CIColor.magenta)


canvas.drawObject(object: triangle)
canvas.drawObject(object: line)

canvas.render()


