import Cocoa

// Bresenham's approach

@inlinable
public func rasterate<F: FloatingPoint>(_ lineBeginPos: Point3D<F>, _ lineEndPos: Point3D<F>,
                                        _ lineBeginColor: CIColor, _ lineEndColor: CIColor,
                                        handler: (Int, Int, Double, Double, Pixel) -> Void) {
    let z0 = Int(lineBeginPos.z as! Double), z1 = Int(lineEndPos.z as! Double)
    
    let flatBeginPos = Point2D<F>(x: lineBeginPos.x, y: lineBeginPos.y)
    let flatEndPos = Point2D<F>(x: lineEndPos.x, y: lineEndPos.y)
    rasterate(flatBeginPos, flatEndPos,
              lineBeginColor, lineEndColor, handler: { x, y, progress, pixel in
                let z = Double(z1 - z0) * progress + Double(z0)
                handler(x, y, z, progress, pixel)
    })
}

@inlinable
public func rasterate<F: FloatingPoint>(_ lineBeginPos: Point2D<F>, _ lineEndPos: Point2D<F>,
                                        _ lineBeginColor: CIColor, _ lineEndColor: CIColor,
                                        handler: (Int, Int, Double, Pixel) -> Void) {
    let singleColor = lineBeginColor == lineEndColor

    var x0 = Int(lineBeginPos.x as! Double)
    var y0 = Int(lineBeginPos.y as! Double)
    var x1 = Int(lineEndPos.x as! Double)
    var y1 = Int(lineEndPos.y as! Double)

    var steep = false
    if abs(x0 - x1) < abs(y0 - y1) {
        (x0, y0) = (y0, x0)
        (x1, y1) = (y1, x1)
        steep = true
    }

    if x0 > x1 {
        (x0, x1) = (x1, x0)
        (y0, y1) = (y1, y0)
    }

    let dx = x1 - x0
    let dy = y1 - y0
    let derror2 = abs(dy) * 2
    var error2 = 0
    var y = y0

    var pixel = color2Pixel(color: lineBeginColor)

    for x in x0 ... x1 {
        let progress = Double(x - x0) / Double(dx)
        if !singleColor {
            pixel = color2Pixel(color: ColorInterpolate(since: lineBeginColor, till: lineEndColor, progress: CGFloat(progress)))
        }

        if steep {
            handler(y, x, progress, pixel)
        } else {
            handler(x, y, progress, pixel)
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
