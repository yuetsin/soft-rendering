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
        
        // reject degenerated lines
        if lineBeginPos == lineEndPos {
            return
        }
        
        rasterize(lineBeginPos, lineEndPos, handler: { point, interp in
            var pixel: Pixel!
            if singleColor {
                pixel = color2Pixel(color: lineBeginColor)
            } else {
                pixel = color2Pixel(color: ColorInterpolate(since: lineBeginColor, till: lineEndColor, interp: interp))
            }
            
            putPixel(pixels: &pixels, point: point, size: canvasSize, target: pixel)
        })
    }
}
