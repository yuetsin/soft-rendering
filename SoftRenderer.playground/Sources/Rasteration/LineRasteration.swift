import Cocoa

// Bresenham's approach
public func rasterize<F: FloatingPoint>(_ lineBeginPos: Point3D<F>, _ lineEndPos: Point3D<F>,
                                        handler: (Point3i, LinearInterpolate<Double>) -> Void) {
    let z0 = lineBeginPos.z as! Double, z1 = lineEndPos.z as! Double
    let flatBeginPos = Point2D<F>(lineBeginPos.x, lineBeginPos.y)
    let flatEndPos = Point2D<F>(lineEndPos.x, lineEndPos.y)
    rasterize(flatBeginPos, flatEndPos,
              handler: { p2i, interp in
                let z = interp.u * z0 + interp.v * z1
                  handler(Point3i(p2i.x, p2i.y, z), interp)
    })
}

public func rasterize<F: FloatingPoint>(_ lineBeginPos: Point2D<F>, _ lineEndPos: Point2D<F>,
                                        handler: (Point2i, LinearInterpolate<Double>) -> Void) {
    var x0 = Int(lineBeginPos.x as! Double)
    var y0 = Int(lineBeginPos.y as! Double)
    var x1 = Int(lineEndPos.x as! Double)
    var y1 = Int(lineEndPos.y as! Double)

    var steep = false
    var inverse = false
    
    if abs(x0 - x1) < abs(y0 - y1) {
        (x0, y0) = (y0, x0)
        (x1, y1) = (y1, x1)
        steep = true
    }

    if x0 > x1 {
        (x0, x1) = (x1, x0)
        (y0, y1) = (y1, y0)
        inverse = true
    }

    let dx = x1 - x0
    let dy = y1 - y0
    let derror2 = abs(dy) * 2
    var error2 = 0
    var y = y0

    for x in x0 ... x1 {
        var progress = Double(x - x0) / Double(dx)
        if inverse {
            progress = 1 - progress
        }
        if steep {
            handler(Point2i(y, x), LinearInterpolate<Double>(u: 1 - progress, v: progress))
        } else {
            handler(Point2i(x, y), LinearInterpolate<Double>(u: 1 - progress, v: progress))
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
