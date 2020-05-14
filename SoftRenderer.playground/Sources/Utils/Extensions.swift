import Cocoa

public func +(left: CIColor, right: CIColor) -> CIColor {
    return CIColor(red: (left.red + right.red).normalize(),
                   green: (left.green + right.green).normalize(),
                   blue: (left.blue + right.blue).normalize(),
                   alpha: (left.alpha + right.alpha).normalize())
}

public func /(left: CIColor, right: CGFloat) -> CIColor {
    return CIColor(red: left.red / right,
                   green: left.green / right,
                   blue: left.blue / right,
                   alpha: left.alpha / right,
                   colorSpace: left.colorSpace) ?? .clear
}


public func *(left: CIColor, right: CGFloat) -> CIColor {
    return CIColor(red: left.red * right,
                   green: left.green * right,
                   blue: left.blue * right,
                   alpha: left.alpha * right,
                   colorSpace: left.colorSpace) ?? .clear
}


public func *(left: CIColor, right: CIColor) -> CIColor {
    return CIColor(red: left.red * right.red,
                   green: left.green * right.green,
                   blue: left.blue * right.blue,
                   alpha: left.alpha * right.alpha,
                   colorSpace: left.colorSpace) ?? .clear
}
