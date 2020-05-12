import Foundation

public class Camera {
    private let fallbackCameraPos = Point3d(x: 5,y: 5, z: 5)
    private let fallbackLookingAtPos = Point3d(x: 0, y: 0, z: 0)
    
    public var cameraPos: Point3d!
    public var lookingAtPos: Point3d!
}
