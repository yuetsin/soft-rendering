import Foundation

public struct LinearInterpolate<F: FloatingPoint> {
  public var u, v: F!

  private let minValue = F(0)
  private let maxValue = F(1)

  public init(u U: F, v V: F) {
    u = min(maxValue, max(minValue, U))
    v = min(maxValue, max(minValue, V))
  }
}
