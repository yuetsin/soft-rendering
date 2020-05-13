
import Foundation

public func transformProjection<F: FloatingPoint>(point: Vector3D<F>, camera: Camera<F>) -> Matrix<F> {
    let worldMatrix = createPointMatrix(point: point)
    let cameraMatrix = createCameraMatrix(camera: camera)
    let perspMatrix = createPerspectiveMatrix(camera: camera)
    
    return perspMatrix * cameraMatrix * worldMatrix
}
