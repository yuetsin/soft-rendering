import Cocoa

public class DirectionalLight: Light {
    
    var shininess: Double!
    var ambient: CIColor!
    var diffuse: CIColor!
    var specular: CIColor!
    
    var direction: Vector3d!
    
    public init(shininess: Double, ambient: CIColor, diffuse: CIColor, specular: CIColor, direction: Vector3d) {
        self.shininess = shininess
        self.ambient = ambient
        self.diffuse = diffuse
        self.specular = specular
        self.direction = direction.normalize()
    }

    public func lighting(material: Material, position: Vector3d, normal: Vector3d, eyeDirection: Vector3d, ambient: inout CIColor, diffuse: inout CIColor, specular: inout CIColor) {
        let diff = CGFloat(max(normal * -direction, 0))
        let halfwayDir = (eyeDirection + direction).normalize()
        
        let spec = pow(CGFloat(max(eyeDirection * halfwayDir, 0)), material.shininess)
        
        ambient = self.ambient
        diffuse = self.diffuse * diff
        specular = self.specular * spec
    }
}
