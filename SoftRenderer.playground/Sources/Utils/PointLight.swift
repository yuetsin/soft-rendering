import Cocoa


public class PointLight: Light {
    
    var ambient: CIColor!
    var diffuse: CIColor!
    var specular: CIColor!
    
    var attenuation: Vector3d!
    var position: Vector3d!
    
    public init(ambient: CIColor, diffuse: CIColor, specular: CIColor, attenuation: Vector3d, position: Vector3d) {
        self.ambient = ambient
        self.diffuse = diffuse
        self.specular = specular
        self.attenuation = attenuation
        self.position = position
    }
    
    public func lighting(material: Material, position: Vector3d, normal: Vector3d, eyeDirection: Vector3d, ambient: inout CIColor, diffuse: inout CIColor, specular: inout CIColor) {
        
        // ambient color: default
        ambient = self.ambient
        
        // diffuse color: cross vector with normal
        let lightDir = (self.position - position).normalize()
        let diff = CGFloat(max(normal * lightDir, 0))
        diffuse = self.diffuse * diff
        
        // specular
        let halfwayDir = (eyeDirection + lightDir).normalize()
        let spec = pow(CGFloat(max(eyeDirection * halfwayDir, 0)), material.shininess)
        specular = self.specular * spec
        
        // attenuation
        let distance = (self.position - position).magnitude()
        let atte = 1 / (attenuation.x + attenuation.y * distance + attenuation.z * distance * distance)
        
        ambient = ambient * CGFloat(atte)
        diffuse = diffuse * CGFloat(atte)
        specular = specular * CGFloat(atte)
    }
}
