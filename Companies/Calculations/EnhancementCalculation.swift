//  Created by Alexander Skorulis on 7/8/2022.

import Foundation

final class EnhancementCalculation {
    
    private static let basePow: Double = 1.25
    private static let baseMult: Double = 1000
    
    func cost(_ number: Int) -> Int {
        let term = pow(Self.basePow, Double(number))
        let doub = Self.baseMult * term
        return Int(ceil(doub))
    }
}
