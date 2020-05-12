import Cocoa

public class Line2D: ObjectDrawProtocol2D {
    var lineBeginPos, lineEndPos: Point2d!
    var lineBeginColor, lineEndColor: CIColor!
    var singleColor: Bool!

    public init(beginPoint: Point2d,
                endPoint: Point2d,
                color: CIColor,
                endColor: CIColor? = nil) {
        lineBeginPos = beginPoint
        lineEndPos = endPoint
        lineBeginColor = color

        // if no `endColor` provided, use begin color instead
        lineEndColor = endColor ?? color

        singleColor = endColor == nil
    }

    public func drawOn(target pixels: inout [Pixel], canvasSize: CGSize) {
        rasterate(lineBeginPos, lineEndPos, lineBeginColor, lineEndColor, handler: { x, y, _, pixel in
            putPixel(pixels: &pixels, x: Int(x), y: Int(y), size: canvasSize, target: pixel)
        })
    }
}
