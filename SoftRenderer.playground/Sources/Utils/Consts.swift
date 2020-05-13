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

// light default values
public let defaultLight = Light(color: CIColor.white, type: .ambient)

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
    
    lines.append(Line3D(beginPoint: Vector3d(), endPoint: Vector3d(length, 0, 0), color: .red))
    lines.append(Line3D(beginPoint: Vector3d(), endPoint: Vector3d(0, length, 0), color: .green))
    lines.append(Line3D(beginPoint: Vector3d(), endPoint: Vector3d(0, 0, length), color: .blue))
    
    return lines
}

public func generateRefrenceLines(distance: Double, count: Int) -> [Line3D] {
    var lines: [Line3D] = []
    
    let length = distance * Double(count * 2)
    
    for i in -count ... count {
        lines.append(Line3D(beginPoint: Vector3d(-length, distance * Double(i), 0),
                            endPoint: Vector3d(length, distance * Double(i), 0),
                            color: .gray))
        lines.append(Line3D(beginPoint: Vector3d(distance * Double(i), -length, 0),
                            endPoint: Vector3d(distance * Double(i), length, 0),
        color: .gray))
    }
    
    return lines
}
