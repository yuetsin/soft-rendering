import Cocoa

public class Triangle: Object2D, ObjectDrawProtocol {
    var tPointA, tPointB, tPointC: Point2d!
    var tColorA, tColorB, tColorC: NSColor!
    var singleColor: Bool!

    public init(objectPosition position: Point2d,
                worldSize size: CGSize,
                pointA: Point2d,
                pointB: Point2d,
                pointC: Point2d,
                colorA: NSColor,
                colorB: NSColor? = nil,
                colorC: NSColor? = nil) {
        super.init(objectPosition: position, worldSize: size)

        tPointA = pointA + position
        tPointB = pointB + position
        tPointC = pointC + position
        tColorA = colorA

        // if no `tColorB` or `tColorC` is provided, use `tColorA` instead
        tColorB = colorB ?? colorA
        tColorC = colorC ?? colorA

        singleColor = colorB == nil || colorC == nil
    }

    public func drawOn(target pixels: inout [Pixel]) {
        if tPointA.y == tPointB.y && tPointA.y == tPointC.y {
            return
        }
        if tPointA.y > tPointB.y {
            (tPointA, tPointB) = (tPointB, tPointA)
        }
        if tPointA.y > tPointC.y {
            (tPointA, tPointC) = (tPointC, tPointA)
        }
        if tPointB.y > tPointC.y {
            (tPointB, tPointC) = (tPointC, tPointB)
        }
        let total_height = Int(tPointC.y - tPointA.y)
        for i in 0 ..< total_height {
            var A, B: Point2d!
            var segment_height, alpha, beta: Double!
            var offset: Int!

            let second_half = Double(i) > tPointB.y - tPointA.y || (tPointB.y == tPointA.y)

            if second_half {
                segment_height = tPointC.y - tPointB.y
                offset = Int(tPointB.y - tPointA.y)
            } else {
                segment_height = tPointB.y - tPointA.y
                offset = 0
            }
            alpha = Double(i) / Double(total_height)
            beta = Double(i - offset) / segment_height
            A = tPointA + (tPointC - tPointA) * alpha
            if second_half {
                B = tPointB + (tPointC - tPointB) * beta
            } else {
                B = tPointA + (tPointB - tPointA) * beta
            }
            if A.x > B.x {
                (A, B) = (B, A)
            }

            for j in Int(A.x) ... Int(B.x) {
                if singleColor {
                    // single color is fine
                    putPixel(pixels: &pixels, x: j, y: Int(tPointA.y) + i, size: worldSize, target: color2Pixel(color: tColorA))
                } else {
                    // Gouraud interpolating
                    let interpColor = GouraudInterpolate(at: Point2d(x: Double(j), y: tPointA.y + Double(i)),
                                                         pointA: tPointA, pointB: tPointB, pointC: tPointC,
                                                         nsColorA: tColorA, nsColorB: tColorB, nsColorC: tColorC)
                    putPixel(pixels: &pixels, x: j, y: Int(tPointA.y) + i, size: worldSize, target: color2Pixel(color: interpColor))
                }
            }
        }
    }
}
