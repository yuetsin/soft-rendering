import Cocoa

class Fragment3D: ObjectDrawProtocol3D {

    var tPointA, tPointB, tPointC: Point3d!
    var tColorA, tColorB, tColorC: CIColor!

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
    }
    
    func drawOn(target: inout [Pixel], canvasSize: CGSize, depthBuffer: inout [Double], lights: inout [Light], camera: Camera) {
        // TODO
    }
}
