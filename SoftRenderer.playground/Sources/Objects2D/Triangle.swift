import Cocoa

public class Triangle: Object2D, ObjectDrawProtocol {

    var tPointA, tPointB, tPointC: Point2d!
    var tColorA, tColorB, tColorC: NSColor!
//    var singleColor: Bool!

    public init(objectPosition position: Point2d,
         worldSize size: CGSize,
         pointA: Point2d,
         pointB: Point2d,
         pointC: Point2d,
         colorA: NSColor,
         colorB: NSColor?,
         colorC: NSColor?) {
        super.init(objectPosition: position, worldSize: size)

        tPointA = pointA
        tPointB = pointB
        tPointC = pointC
        tColorA = colorA
        
        // if no `tColorB` or `tColorC` is provided, use `tColorA` instead
        tColorB = colorB ?? colorA
        tColorC = colorC ?? colorA

//        singleColor = colorB == nil || colorC == nil
    }
    
    public func drawOn(target: inout [Pixel]) {

    }
}
