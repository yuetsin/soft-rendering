import Foundation

// base class of all 3-dimension objects
// they will be rendered on the screen after being captured by the camera

public class Object3D {
    var cameraPosition: Point3d!
    var objectPosition: Point3d!
    
    init(cameraPosition cameraP: Point3d, objectPosition objectP: Point3d) {
        cameraPosition = cameraP
        objectPosition = objectP
    }
}
