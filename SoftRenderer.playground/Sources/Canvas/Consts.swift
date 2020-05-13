import Cocoa

// basic type aliases
public typealias Point2d = Point2D<Double>
public typealias Point2f = Point2D<Float>
public typealias Point3d = Point3D<Double>
public typealias Point3f = Point3D<Float>

// canvas default values
public let defaultSize = CGSize(width: 1024, height: 1024)
public let defaultColor = CIColor.clear

// camera default values
public let defaultCameraPosition = Point3d(2, 2, 2)
public let defaultLookingAtPosition = Point3d(0, 0, 0)
public let defaultCamera = Camera(position: defaultCameraPosition, lookingAtPosition: defaultLookingAtPosition)

// light default values
public let defaultLight = Light(color: CIColor.white, type: .ambient)

public func generateCube(basePoint: Point3d, size: Double) -> [TextureFragment3D] {
    
    var fragments: [TextureFragment3D] = []
    
    fragments.append(TextureFragment3D(pointA: basePoint,
    pointB: basePoint + Point3d(0, size, 0),
    pointC: basePoint + Point3d(size, 0, 0),
    texImage: NSImage(imageLiteralResourceName: "grass.png"),
    coordsA: .leftTop,
    coordsB: .leftBottom,
    coordsC: .rightTop))
    
    fragments.append(TextureFragment3D(pointA: basePoint + Point3d(size, size, 0),
    pointB: basePoint + Point3d(0, size, 0),
    pointC: basePoint + Point3d(size, 0, 0),
    texImage: NSImage(imageLiteralResourceName: "grass.png"),
    coordsA: .rightBottom,
    coordsB: .leftBottom,
    coordsC: .rightTop))
    
    return fragments
}
