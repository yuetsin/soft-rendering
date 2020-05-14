import Cocoa

public class Line3D: ObjectDrawProtocol3D {
    var lineBeginPos, lineEndPos: Vector3d!
    var lineBeginColor, lineEndColor: CIColor!
    var singleColor: Bool!

    public init(beginPoint: Vector3d,
                endPoint: Vector3d,
                color: CIColor,
                endColor: CIColor? = nil) {
        lineBeginPos = beginPoint
        lineEndPos = endPoint
        lineBeginColor = color

        // if no `endColor` provided, use begin color instead
        lineEndColor = endColor ?? color

        singleColor = endColor == nil
    }

    public func drawOn(target pixels: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double], lights: inout [Light], camera: Camera<Double>) {
        let pBegin = transformPoint(point: lineBeginPos, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))
        let pEnd = transformPoint(point: lineEndPos, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))

        rasterize(canvasWidth: Double(canvasSize.width), canvasHeight: Double(canvasSize.height), pBegin, pEnd, handler: { point, interp in
            let x = point.x, y = point.y, z = point.z
            var pixel: Pixel!
            if singleColor {
                pixel = color2Pixel(color: lineBeginColor)
            } else {
                pixel = color2Pixel(color: LinearColorInterpolate(since: lineBeginColor, till: lineEndColor, interp: interp))
            }
            if getZBuffer(zBuffer: &depthBuffer, x: x, y: y, size: canvasSize) ?? Double.infinity >= z {
                putZBuffer(zBuffer: &depthBuffer, x: x, y: y, size: canvasSize, target: z)
                putPixel(pixels: &pixels, x: x, y: y, size: canvasSize, target: pixel)
            }
        })
    }
}
