import Foundation

public struct FragmentInterpolate<F: FloatingPoint> {
  public var u, v, w: F!

  private let minValue = F(0)
  private let maxValue = F(1)

  // due to precision issues, calculating result might exceed 0 or 1.
  // normalize it to avoid critical errors.
  public init(u U: F, v V: F, w W: F) {
    u = min(maxValue, max(minValue, U))
    v = min(maxValue, max(minValue, V))
    w = min(maxValue, max(minValue, W))
  }
}
