import Foundation

public class Camera {
    public var cameraPos: Vector3d!
    public var lookingAtPos: Vector3d!
    public var upVector: Vector3d!
    
    public init(position: Vector3d, lookingAtPosition: Vector3d) {
        cameraPos = position
        lookingAtPos = lookingAtPosition
    }
}
