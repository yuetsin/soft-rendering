import Cocoa

// basic type aliases
public typealias Vector2d = Vector2D<Double>
public typealias Vector2f = Vector2D<Float>
public typealias Vector3d = Vector3D<Double>
public typealias Vector3f = Vector3D<Float>

// canvas default values
public let defaultSize = CGSize(width: 1024, height: 1024)
public let defaultColor = CIColor.clear

// camera default values
public let defaultCameraPosition = Vector3d(3, 3, 3)
public let defaultLookingAtPosition = Vector3d(0, 0, 0)
public let defaultCamera = Camera(position: defaultCameraPosition, lookingAtPosition: defaultLookingAtPosition, upVector: Vector3d(0, 0, 1), cameraFov: 1, cameraAspect: 1, camZn: 1, camZf: 2)

// material default values
public let defaultMaterial = Material(shininess: 0.5,
                                      ambientColor: .white,
                                      diffuseColor: .white,
                                      specularColor: .white,
                                      reflectColor: .white)
public let defaultShininess: CGFloat = 0.5

public let halfTransparentWhite = CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
public let defaultLights: [Light] = [
    DirectionalLight(shininess: 0.75,
                     ambient: .white,
                     diffuse: .white,
                     specular: .white,
                     direction: Vector3d(0, 0, -1)),

    PointLight(ambient: .white,
               diffuse: .white,
               specular: .white,
               attenuation: Vector3d(1, 1, 1),
               position: Vector3d(0, 0, 2)),

    SpotLight(cutOff: 0.5, outCutOff: 2.0,
              ambient: .white, diffuse: .white, specular: .white,
              position: Vector3d(2, 2, 2),
              direction: Vector3d(0, 0, -1),
              attenuation: Vector3d(1, 1, 1))]

public func generateCube(basePoint: Vector3d, size: Double) -> [TextureFragment3D] {
    var fragments: [TextureFragment3D] = []
    
    fragments.append(TextureFragment3D(pointA: basePoint,
    pointB: basePoint + Vector3d(0, size, 0),
    pointC: basePoint + Vector3d(size, 0, 0),
    texImage: NSImage(imageLiteralResourceName: "grass.png"),
    coordsA: .leftTop,
    coordsB: .leftBottom,
    coordsC: .rightTop))
    
    fragments.append(TextureFragment3D(pointA: basePoint + Vector3d(size, size, 0),
    pointB: basePoint + Vector3d(0, size, 0),
    pointC: basePoint + Vector3d(size, 0, 0),
    texImage: NSImage(imageLiteralResourceName: "grass.png"),
    coordsA: .rightBottom,
    coordsB: .leftBottom,
    coordsC: .rightTop))
    
    return fragments
}

public func generateAxis(length: Double) -> [Line3D] {
    var lines: [Line3D] = []
    
    lines.append(Line3D(beginPoint: Vector3d(-length, 0, 0), endPoint: Vector3d(length, 0, 0), color: .red))
    lines.append(Line3D(beginPoint: Vector3d(0, -length, 0), endPoint: Vector3d(0, length, 0), color: .green))
    lines.append(Line3D(beginPoint: Vector3d(0, 0, -length), endPoint: Vector3d(0, 0, length), color: .blue))
    
    return lines
}

public func generateRefrenceLines(distance: Double, count: Int) -> [Line3D] {
    var lines: [Line3D] = []
    
    let length = distance * Double(count * 2)
    
    for i in -count ... count {
        if i == 0 {
            continue
        }
        lines.append(Line3D(beginPoint: Vector3d(-length, distance * Double(i), 0),
                            endPoint: Vector3d(length, distance * Double(i), 0),
                            color: .white, endColor: .black))
        lines.append(Line3D(beginPoint: Vector3d(distance * Double(i), -length, 0),
                            endPoint: Vector3d(distance * Double(i), length, 0),
        color: .white, endColor: .black))
    }
    
    return lines
}
