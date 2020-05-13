import Foundation

public class Camera<F: FloatingPoint> {
    public var eyePos: Vector3D<F>!
    public var lookingAtPos: Vector3D<F>!
    public var up: Vector3D<F>!
    public var fov: F!
    public var aspect: F!
    public var zn: F!
    public var zf: F!
    
    private var cameraMatrix: Matrix<F>!
    
    public init(position: Vector3D<F>, lookingAtPosition: Vector3D<F>, upVector: Vector3D<F>, cameraFov: F, cameraAspect: F, camZn: F, camZf: F) {
        eyePos = position
        lookingAtPos = lookingAtPosition
        up = upVector
        
        fov = cameraFov
        aspect = cameraAspect
        zn = camZn
        zf = camZf

        cameraMatrix = createCameraMatrix(camera: self)
    }
}
