//  Created by Alexander Skorulis on 2/8/2022.

import Foundation

struct ShortNumberFormatter {
    
    static let standard: ShortNumberFormatter = ShortNumberFormatter()
    
    private static let singleDigit: NumberFormatter = {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func format(_ number: Int) -> String {
        let ab = abs(number)
        let sign = number < 0 ? "-" : ""
        if ab < 1000 {
            return "\(sign)\(ab)"
        } else if ab < 1000000 {
            let thousands = Float(ab) / 1000
            let numString = Self.singleDigit.string(from: thousands as NSNumber)!
            return "\(sign)\(numString)K"
        } else {
            let millions = Float(ab) / 1000000
            let numString = Self.singleDigit.string(from: millions as NSNumber)!
            return "\(sign)\(numString)M"
        }
    }
    
    
}
