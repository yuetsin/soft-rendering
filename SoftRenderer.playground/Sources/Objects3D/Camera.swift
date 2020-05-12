import Foundation

public class Camera {
    public var cameraPos: Point3d!
    public var lookingAtPos: Point3d!
    
    public init(position: Point3d, lookingAtPosition: Point3d) {
        cameraPos = position
        lookingAtPos = lookingAtPosition
    }
}
