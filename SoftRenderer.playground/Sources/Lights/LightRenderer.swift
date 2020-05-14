import Cocoa

@inlinable
public func renderLight(
  lights: [Light], material: Material, camera: Camera<Double>, position: Vector3d, normal: Vector3d
) -> CIColor {
  if lights.count == 0 {
    return material.ambientColor
  }
  var ambient: CIColor = .clear
  var diffuse: CIColor = .clear
  var specular: CIColor = .clear
  for light in lights {
    light.lighting(
      material: material,
      position: position,
      normal: normal,
      eyeDirection: camera.lookingAtPos - camera.eyePos,
      ambient: &ambient, diffuse: &diffuse, specular: &specular)
  }
  return material.ambientColor * ambient + material.diffuseColor * diffuse + material.specularColor
    * specular
}
