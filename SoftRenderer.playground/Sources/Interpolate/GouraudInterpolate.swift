import Cocoa

public func GouraudInterpolate(
  colorA: CIColor, colorB: CIColor, colorC: CIColor, interp: FragmentInterpolate<Double>
) -> CIColor {

  let u = CGFloat(interp.u)
  let v = CGFloat(interp.v)
  let w = CGFloat(interp.w)

  let red = colorA.red * u + colorB.red * v + colorC.red * w
  let green = colorA.green * u + colorB.green * v + colorC.green * w
  let blue = colorA.blue * u + colorB.blue * v + colorC.blue * w
  let alpha = colorA.alpha * u + colorB.alpha * v + colorC.alpha * w

  return CIColor(
    red: red.normalize(), green: green.normalize(), blue: blue.normalize(), alpha: alpha.normalize()
  )
}

public func GouraudInterpolateWithCorrection(
  colorA: CIColor, colorB: CIColor, colorC: CIColor,
  interp: FragmentInterpolate<Double>,
  zA: Double, zB: Double, zC: Double, refZ: Double
) -> CIColor {

  let u = CGFloat(interp.u)
  let v = CGFloat(interp.v)
  let w = CGFloat(interp.w)

  let cA = colorA / CGFloat(zA)
  let cB = colorB / CGFloat(zB)
  let cC = colorC / CGFloat(zC)
  let z = CGFloat(refZ)

  let red = cA.red * u + cB.red * v + cC.red * w
  let green = cA.green * u + cB.green * v + cC.green * w
  let blue = cA.blue * u + cB.blue * v + cC.blue * w
  let alpha = cA.alpha * u + cB.alpha * v + cC.alpha * w

  return CIColor(
    red: (red * z).normalize(), green: (green * z).normalize(), blue: (blue * z).normalize(),
    alpha: (alpha * z).normalize())
}
