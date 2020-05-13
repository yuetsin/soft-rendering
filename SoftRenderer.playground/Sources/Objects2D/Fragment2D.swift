import Cocoa

public class Fragment2D: ObjectDrawProtocol2D {
    var tPointA, tPointB, tPointC: Vector2d!
    var tColorA, tColorB, tColorC: CIColor!
    var singleColor: Bool!

    public init(pointA: Vector2d,
                pointB: Vector2d,
                pointC: Vector2d,
                colorA: CIColor,
                colorB: CIColor? = nil,
                colorC: CIColor? = nil) {
        tPointA = pointA
        tPointB = pointB
        tPointC = pointC
        tColorA = colorA

        // if no `tColorB` or `tColorC` is provided, use `tColorA` instead
        tColorB = colorB ?? colorA
        tColorC = colorC ?? colorA

        singleColor = colorB == nil || colorC == nil
    }

    public func drawOn(target pixels: inout [Pixel], canvasSize: CGSize) {
        if tPointA.y == tPointB.y && tPointA.y == tPointC.y {
            return
        }
        
        rasterize(canvasWidth: Double(canvasSize.width), canvasHeight: Double(canvasSize.height), pA: tPointA, pB: tPointB, pC: tPointC) { point, interp in
            
            var pixel: Pixel!
            if singleColor {
                pixel = color2Pixel(color: tColorA)
            } else {
                let color = GouraudInterpolate(colorA: tColorA, colorB: tColorB, colorC: tColorC, interp: interp)
                pixel = color2Pixel(color: color)
            }
            putPixel(pixels: &pixels, point: point, size: canvasSize, target: pixel)
        }
    }
}
