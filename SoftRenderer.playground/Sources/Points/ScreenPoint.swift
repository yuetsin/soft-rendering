import Foundation

public class ScreenPoint<F: FloatingPoint> {
    public var x: F
    public var y: F
    
    public init(_ X: F, _ Y: F) {
        x = X
        y = Y
    }
    
    public init() {
        x = .zero
        y = .zero
    }
}
