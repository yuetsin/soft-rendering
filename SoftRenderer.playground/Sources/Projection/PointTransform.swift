import Foundation

func transformPoint<F: FloatingPoint>(point: Vector3D<F>, camera: Camera<F>, width: F, height: F) -> Vector3D<F> {
    let transformed = transformProjection(point: point, camera: camera)

    let x = transformed.get(row: 0, column: 0) ?? .zero
    let y = transformed.get(row: 1, column: 0) ?? .zero
    let z = transformed.get(row: 2, column: 0) ?? .zero
    let w = transformed.get(row: 3, column: 0) ?? .zero

//    if cropCheck(x: x, y: y, z: z, w: w) {
//        return
//    }
    
    let one = 1.0 as! F
    let two = 2.0 as! F
    
    let rhw = one / w
    let screenX = (x * rhw + one) * width / two
    let screenY = (one - y * rhw) * height / two

    return Vector3D<F>(screenX, screenY, z)
}
