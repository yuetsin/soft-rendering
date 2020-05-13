import Cocoa

public class Fragment3D: ObjectDrawProtocol3D {
    var tPointA, tPointB, tPointC: Point3d!
    var tColorA, tColorB, tColorC: CIColor!

    var singleColor: Bool!

    public init(pointA: Point3d,
                pointB: Point3d,
                pointC: Point3d,
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

    public func drawOn(target pixels: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double], lights: inout [Light], camera: Camera) {
        rasterize(pA: tPointA, pB: tPointB, pC: tPointC, handler: { point, interp in
            var pixel: Pixel!

            if getZBuffer(zBuffer: &depthBuffer, x: point.x, y: point.y, size: canvasSize) ?? -Double.infinity <= point.z {
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
