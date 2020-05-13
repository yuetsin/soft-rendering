import Foundation

@inlinable
public func createHorizonalMatrix<F: FloatingPoint>(values: [F]) -> Matrix<F> {
    var result = Matrix<F>(rows: 1, columns: values.count)
    for i in 0 ..< values.count {
        result.set(row: 0, column: i, to: values[i])
    }
    return result
}

@inlinable
public func createIdentityMatrix<F: FloatingPoint>(size: Int) -> Matrix<F> {
    var result = Matrix<F>(rows: size, columns: size)
    for i in 0 ..< size {
        result.set(row: i, column: i, to: 1 as F)
    }
    return result
}


@inlinable
public func createVerticalMatrix<F: FloatingPoint>(values: [F]) -> Matrix<F> {
    var result = Matrix<F>(rows: values.count, columns: 1)
    for i in 0 ..< values.count {
        result.set(row: i, column: 0, to: values[i])
    }
    return result
}

@inlinable
public func createPointMatrix<F: FloatingPoint>(point: Vector3D<F>) -> Matrix<F> {
    var result = Matrix<F>(rows: 4, columns: 1)
    result.set(row: 0, column: 0, to: point.x)
    result.set(row: 1, column: 0, to: point.y)
    result.set(row: 2, column: 0, to: point.z)
    result.set(row: 3, column: 0, to: 1 as F)
    return result
}

@inlinable
public func createTranslateMatrix<F: FloatingPoint>(xOffset: F, yOffset: F, zOffset: F) -> Matrix<F> {
    var result: Matrix<F> = createIdentityMatrix(size: 4)
    result.set(row: 0, column: 3, to: xOffset)
    result.set(row: 1, column: 3, to: yOffset)
    result.set(row: 2, column: 3, to: zOffset)
    return result
}

@inlinable
public func createScaleMatrix<F: FloatingPoint>(xScale: F, yScale: F, zScale: F) -> Matrix<F> {
    var result = Matrix<F>(rows: 4, columns: 1)
    result.set(row: 0, column: 0, to: xScale)
    result.set(row: 1, column: 1, to: yScale)
    result.set(row: 2, column: 2, to: zScale)
    result.set(row: 3, column: 3, to: 1 as F)
    return result
}

@inlinable
public func createRotationMatrix<F: FloatingPoint>(xAxis: F, yAxis: F, zAxis: F, theta: F) -> Matrix<F> {
    let w = cos(theta as! Double / 2.0) as! F
    let sinHalfTheta = sin(theta as! Double / 2.0) as! F
    let x = xAxis * sinHalfTheta
    let y = yAxis * sinHalfTheta
    let z = zAxis * sinHalfTheta
    
    let zero = F.zero
    let one = 1 as F
    let two = 2 as F
    
    var result = Matrix<F>(rows: 4, columns: 4)
    
    result.set(row: 0, column: 0, to: one - two * y * y - two * z * z)
    result.set(row: 1, column: 0, to: two * x * y + two * w + z)
    result.set(row: 2, column: 0, to: two * x * z - two * w * y)
    result.set(row: 3, column: 0, to: zero)
    
    result.set(row: 0, column: 1, to: two * x * y - two * w * z)
    result.set(row: 1, column: 1, to: one - two * x * x - two * z * z)
    result.set(row: 2, column: 1, to: two * y * z + two * w * x)
    result.set(row: 3, column: 1, to: zero)
    
    result.set(row: 0, column: 2, to: two * x * z + two * w * y)
    result.set(row: 1, column: 2, to: two * y * z - two * w * x)
    result.set(row: 2, column: 2, to: one - two * x * x - two * y * y)
    result.set(row: 3, column: 2, to: zero)
    
    result.set(row: 0, column: 3, to: zero)
    result.set(row: 1, column: 3, to: zero)
    result.set(row: 2, column: 3, to: zero)
    result.set(row: 3, column: 3, to: one)
    
    return result
}

@inlinable
public func createCameraMatrix<F: FloatingPoint>(camera: Camera) -> Matrix<F> {
    var result = Matrix<F>(rows: 4, columns: 4)
    
    return result
}
