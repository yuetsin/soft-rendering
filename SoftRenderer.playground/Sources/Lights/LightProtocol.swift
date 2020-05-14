import Cocoa

public protocol Light {
  func lighting(
    material: Material, position: Vector3d, normal: Vector3d, eyeDirection: Vector3d,
    ambient: inout CIColor, diffuse: inout CIColor, specular: inout CIColor)
}
