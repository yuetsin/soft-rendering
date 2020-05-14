import Cocoa

public class Fragment3D: ObjectDrawProtocol3D {
    var tPointA, tPointB, tPointC: Vector3d!
    var tColorA, tColorB, tColorC: CIColor!

    var singleColor: Bool!

    public init(pointA: Vector3d,
                pointB: Vector3d,
                pointC: Vector3d,
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

    public func drawOn(target pixels: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double], lights: inout [Light], camera: Camera<Double>) {
        
        let pA = transformPoint(point: tPointA, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))
        let pB = transformPoint(point: tPointB, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))
        let pC = transformPoint(point: tPointC, camera: camera, width: Double(canvasSize.width), height: Double(canvasSize.height))
        
        rasterize(canvasWidth: Double(canvasSize.width), canvasHeight: Double(canvasSize.height), pA: pA, pB: pB, pC: pC, handler: { point, interp in
            var pixel: Pixel!

            if getZBuffer(zBuffer: &depthBuffer, x: point.x, y: point.y, size: canvasSize) ?? Double.infinity >= point.z {
                if singleColor {
                    pixel = color2Pixel(color: tColorA)
                } else {
                    let color = GouraudInterpolate(colorA: tColorA, colorB: tColorB, colorC: tColorC, interp: interp)
                    pixel = color2Pixel(color: color)
                }
                putPixel(pixels: &pixels, x: point.x, y: point.y, size: canvasSize, target: pixel)
                putZBuffer(zBuffer: &depthBuffer, x: point.x, y: point.y, size: canvasSize, target: point.z)
            }
        })
    }
}
