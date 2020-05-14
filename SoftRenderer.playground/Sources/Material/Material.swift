import Cocoa

public struct Material {
    public init(shininess: CGFloat, color: CIColor) {
        self.shininess = shininess
        self.ambientColor = color
        self.diffuseColor = color
        self.specularColor = color
        self.reflectColor = color
    }
    
    public init(shininess: CGFloat, ambientColor: CIColor, diffuseColor: CIColor, specularColor: CIColor, reflectColor: CIColor) {
        self.shininess = shininess
        self.ambientColor = ambientColor
        self.diffuseColor = diffuseColor
        self.specularColor = specularColor
        self.reflectColor = reflectColor
    }
    
    public var shininess: CGFloat
    public var ambientColor: CIColor
    public var diffuseColor: CIColor
    public var specularColor: CIColor
    public var reflectColor: CIColor
}
