import Cocoa

public class Light {
    public var lightColor: CIColor!
    public var lightType: LightType!
    
    // ambient light doesn't require lightPosition
    public var lightPosition: Point3d?
    
    public init(color: CIColor,
                type: LightType,
                position: Point3d? = nil) {
        lightColor = color
        lightType = type
        
        if type != .ambient {
            if position == nil {
                fatalError("\(type) light should have a position")
            }
            lightPosition = position
        }
    }
}

public enum LightType {
    case ambient
    case diffuse
    case specular
}
