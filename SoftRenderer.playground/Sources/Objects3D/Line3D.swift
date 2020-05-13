import Cocoa

public class Line3D: ObjectDrawProtocol3D {
    var lineBeginPos, lineEndPos: Point3d!
    var lineBeginColor, lineEndColor: CIColor!
    var singleColor: Bool!

    public init(beginPoint: Point3d,
                endPoint: Point3d,
                color: CIColor,
                endColor: CIColor? = nil) {
        lineBeginPos = beginPoint
        lineEndPos = endPoint
        lineBeginColor = color

        // if no `endColor` provided, use begin color instead
        lineEndColor = endColor ?? color

        singleColor = endColor == nil
    }

    public func drawOn(target pixels: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double], lights: inout [Light], camera: Camera) {
        rasterize(lineBeginPos, lineEndPos, handler: { point, interp in
            let x = point.x, y = point.y, z = point.z
            var pixel: Pixel!
            if singleColor {
                pixel = color2Pixel(color: lineBeginColor)
            } else {
                pixel = color2Pixel(color: ColorInterpolate(since: lineBeginColor, till: lineEndColor, interp: interp))
            }
            if getZBuffer(zBuffer: &depthBuffer, x: x, y: y, size: canvasSize) ?? -Double.infinity <= z {
                putZBuffer(zBuffer: &depthBuffer, x: x, y: y, size: canvasSize, target: z)
                putPixel(pixels: &pixels, x: x, y: y, size: canvasSize, target: pixel)
            }
        })
    }
}
