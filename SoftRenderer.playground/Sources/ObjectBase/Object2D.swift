import Foundation

// base class of all 2-dimension objects
// they will be directly rendered on the screen

public class Object2D {
    var objectPosition: Point2d!
    var worldSize: CGSize!
    
    init(objectPosition position: Point2d, worldSize size: CGSize) {
        objectPosition = position
        worldSize = size
    }
}
