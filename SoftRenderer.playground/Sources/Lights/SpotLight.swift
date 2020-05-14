import Cocoa

public class SpotLight: Light {

  var cutOff, outCutOff: Double!
  var ambient: CIColor!
  var diffuse: CIColor!
  var specular: CIColor!

  var position: Vector3d!
  var direction: Vector3d!
  var attenuation: Vector3d!

  public init(
    cutOff: Double, outCutOff: Double, ambient: CIColor, diffuse: CIColor, specular: CIColor,
    position: Vector3d, direction: Vector3d, attenuation: Vector3d
  ) {
    self.cutOff = cutOff
    self.outCutOff = outCutOff
    self.ambient = ambient
    self.diffuse = diffuse
    self.specular = specular
    self.position = position
    self.direction = direction
    self.attenuation = attenuation
  }

  public func lighting(
    material: Material, position: Vector3d, normal: Vector3d, eyeDirection: Vector3d,
    ambient: inout CIColor, diffuse: inout CIColor, specular: inout CIColor
  ) {
    ambient = self.ambient

    // diffuse color: cross vector with normal
    let lightDir = (self.position - position).normalize()
    let diff = CGFloat(max(normal * lightDir, 0))
    diffuse = self.diffuse * diff

    // specular
    let halfwayDir = (eyeDirection + lightDir).normalize()
    let spec = pow(CGFloat(max(eyeDirection * halfwayDir, 0)), material.shininess)
    specular = self.specular * spec

    // spotlight with soft edges
    let theta = lightDir * (-self.direction)
    let epsilon = self.cutOff - self.outCutOff
    let intensity = CGFloat(((theta - self.outCutOff) / epsilon).normalize())

    diffuse = diffuse * intensity
    specular = specular * intensity

    // attenuation
    let distance = (self.position - position).magnitude()
    let atte = 1 / (attenuation.x + attenuation.y * distance + attenuation.z * distance * distance)

    ambient = ambient * CGFloat(atte)
    diffuse = diffuse * CGFloat(atte)
    specular = specular * CGFloat(atte)
  }
}
