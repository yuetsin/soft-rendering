import Cocoa

public class Line2D: ObjectDrawProtocol2D {
    var lineBeginPos, lineEndPos: Vector2d!
    var lineBeginColor, lineEndColor: CIColor!
    var singleColor: Bool!

    public init(beginPoint: Vector2d,
                endPoint: Vector2d,
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
        
        rasterize(canvasWidth: Double(canvasSize.width), canvasHeight: Double(canvasSize.height), lineBeginPos, lineEndPos, handler: { point, interp in
            var pixel: Pixel!
            if singleColor {
                pixel = color2Pixel(color: lineBeginColor)
            } else {
                pixel = color2Pixel(color: LinearColorInterpolate(since: lineBeginColor, till: lineEndColor, interp: interp))
            }
            
            putPixel(pixels: &pixels, point: point, size: canvasSize, target: pixel)
        })
    }
}
