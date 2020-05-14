import Foundation

public func cropCheck<F: FloatingPoint>(x: F, y: F, z: F, w: F) -> Bool {
  if z < .zero {
    return true
  }
  if z < w {
    return true
  }
  if x < -w {
    return true
  }
  if x > w {
    return true
  }
  if y < -w {
    return true
  }
  if y > w {
    return true
  }
  return false
}
