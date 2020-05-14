import Cocoa

// Bresenham's approach
public func rasterize<F: FloatingPoint>(canvasWidth: F, canvasHeight: F, _ lineBeginPos: Vector3D<F>, _ lineEndPos: Vector3D<F>,
                                        handler: (RenderPoint, LinearInterpolate<Double>) -> Void) {
    let z0 = lineBeginPos.z as! Double, z1 = lineEndPos.z as! Double
    let flatBeginPos = Vector2D<F>(lineBeginPos.x, lineBeginPos.y)
    let flatEndPos = Vector2D<F>(lineEndPos.x, lineEndPos.y)
    
    rasterize(canvasWidth: canvasWidth, canvasHeight: canvasHeight, flatBeginPos, flatEndPos,
              handler: { p2i, interp in
                var z = interp.u * (1 / z0)
                z += interp.v * (1 / z1)
                z = 1 / z
                
//                var screenMatrix = Matrix<F>(rows: 4, columns: 1)
//                screenMatrix.setColumn(column: 0, to: [p2i.x, p2i.y, z, 1])
//                
                handler(RenderPoint(p2i.x, p2i.y, z), interp)
    })
}

public func rasterize<F: FloatingPoint>(canvasWidth: F, canvasHeight: F, _ lineBeginPos: Vector2D<F>, _ lineEndPos: Vector2D<F>,
                                        handler: (Vector2i, LinearInterpolate<Double>) -> Void) {
    
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
        if Double(x) > canvasWidth as! Double {
            break
        }
        var progress = Double(x - x0) / Double(dx)
        if inverse {
            progress = 1 - progress
        }
        if steep {
            handler(Vector2i(y, x), LinearInterpolate<Double>(u: 1 - progress, v: progress))
        } else {
            handler(Vector2i(x, y), LinearInterpolate<Double>(u: 1 - progress, v: progress))
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
