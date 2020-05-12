import Cocoa

public class Line: Object2D, ObjectDrawProtocol {
    var lineBeginPos, lineEndPos: Point2d!
    var lineBeginColor, lineEndColor: CIColor!
//    var lineStrokeWidth: CGFloat!
    var singleColor: Bool!

    public init(objectPosition position: Point2d,
                worldSize size: CGSize,
//                strokeWidth: CGFloat,
                beginPoint: Point2d,
                endPoint: Point2d,
                color: CIColor,
                endColor: CIColor? = nil) {
        super.init(objectPosition: position, worldSize: size)

        objectPosition = position
        worldSize = size

//        lineStrokeWidth = strokeWidth

        // should have a basePosition
        lineBeginPos = beginPoint + position
        lineEndPos = endPoint + position
        lineBeginColor = color

        // if no `endColor` provided, use begin color instead
        lineEndColor = endColor ?? color
        
        singleColor = endColor == nil
    }

    public func drawOn(target pixels: inout [Pixel]) {
        // Bresenham's approach
        var x0 = Int(lineBeginPos.x), y0 = Int(lineBeginPos.y)
        var x1 = Int(lineEndPos.x), y1 = Int(lineEndPos.y)

        var steep = false
        if abs(x0 - x1) < abs(y0 - y1) {
            (x0, y0) = (y0, x0)
            (x1, y1) = (y1, x1)
            steep = true
        }

        if x0 > x1 {
            (x0, x1) = (x1, x0)
            (y0, y1) = (y1, y0)
        }

        let dx = x1 - x0
        let dy = y1 - y0
        let derror2 = abs(dy) * 2
        var error2 = 0
        var y = y0
        
        var pixel = color2Pixel(color: lineBeginColor)
        
        for x in x0 ... x1 {
            if !singleColor {
                pixel = color2Pixel(color: ColorInterpolate(since: lineBeginColor, till: lineEndColor, progress: CGFloat(x - x0) / CGFloat(dx)))
            }
            if steep {
                putPixel(pixels: &pixels, x: y, y: x, size: worldSize, target: pixel)
            } else {
                putPixel(pixels: &pixels, x: x, y: y, size: worldSize, target: pixel)
            }
            error2 += derror2
            if error2 > dx {
                if y1 > y0 {
                    y += 1
                } else {
                    y -= 1
                }
                error2 -= dx * 2
            }
        }
    }
}
