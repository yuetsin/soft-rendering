import Cocoa

public class Light {
    public var lightColor: CIColor!
    public var lightPosition: Point3d!
    public var lightType: LightType!
    
    public init(color: CIColor,
                position: Point3d,
                type: LightType) {
        lightColor = color
        lightPosition = position
        lightType = type
    }
}

public enum LightType {
    case ambient
    case diffuse
    case specular
}
