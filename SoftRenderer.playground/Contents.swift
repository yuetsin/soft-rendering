import Cocoa
import PlaygroundSupport

//: initialize a `SRCanvas`
var canvas = SRCanvas(size: CGSize(width: 550, height: 400), color: .brown)

PlaygroundPage.current.liveView = canvas

let line = Line(objectPosition: Point2d(x: 10, y: 10),
                worldSize: canvas.imageSize,
                strokeWidth: 3.0,
                beginPoint: Point2d(x: 10, y: 10),
                endPoint: Point2d(x: 30, y: 20), color: NSColor.red, endColor: NSColor.blue)

canvas.drawObject(object: line)

canvas.render()
