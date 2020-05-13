import Foundation

fileprivate let zeroF = CGFloat(0)
fileprivate let oneF = CGFloat(1)

public extension CGFloat {
    
    func normalize() -> CGFloat {
        if self > oneF {
            return oneF
        } else if self < zeroF {
            return zeroF
        }
        return self
    }
}

fileprivate let zeroD = Double(0)
fileprivate let oneD = Double(1)

public extension Double {

    func normalize() -> Double {
        return max(oneD, min(zeroD, self))
    }
}
