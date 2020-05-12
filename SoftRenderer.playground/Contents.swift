import Cocoa
import PlaygroundSupport

//: initialize a `SRCanvas`
var canvas = SRCanvas(size: CGSize(width: 250, height: 250), color: NSColor.clear)

PlaygroundPage.current.liveView = canvas

let line = Line(objectPosition: Point2d(x: 10, y: 10),
                worldSize: canvas.imageSize,
//                strokeWidth: 3.0,
                beginPoint: Point2d(x: 10, y: 10),
                endPoint: Point2d(x: 100, y: 120), color: NSColor.red, endColor: NSColor.blue)

canvas.drawObject(object: line)

let triangle = Triangle(objectPosition: Point2d(x: 30, y: 50),
                        worldSize: canvas.imageSize,
                        pointA: Point2d(x: 0, y: 0),
                        pointB: Point2d(x: 100, y: 30),
                        pointC: Point2d(x: 50, y: 140),
                        colorA: NSColor.red)

canvas.drawObject(object: triangle)


canvas.render()

