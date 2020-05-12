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
        rasterate(lineBeginPos, lineEndPos, lineBeginColor, lineEndColor, handler: { x, y, z, _, pixel in
            let xInt = Int(x), yInt = Int(y)
            if getZBuffer(zBuffer: &depthBuffer, x: xInt, y: yInt, size: canvasSize) ?? Double.infinity <= Double(z) {
                putZBuffer(zBuffer: &depthBuffer, x: xInt, y: yInt, size: canvasSize, target: Double(z))
                putPixel(pixels: &pixels, x: xInt, y: yInt, size: canvasSize, target: pixel)
            }
        })
    }
}
