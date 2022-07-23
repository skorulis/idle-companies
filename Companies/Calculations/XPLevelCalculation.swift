//  Created by Alexander Skorulis on 22/7/2022.

import Foundation

final class XPLevelCalculation {
    
    private static let basePow: Double = 1.25
    private static let baseMult: Double = 200
    
    /// Get the total XP required for level x
    func totalXP(_ level: Int) -> Int64 {
        let term = pow(Self.basePow, Double(level)) - Self.basePow
        let doub = Self.baseMult * term
        return Int64(ceil(doub))
    }
    
    /// Get the level given an XP value
    func level(_ xp: Int64) -> Int {
        if xp <= 0 {
            return 1
        }
        let term = (Double(xp) / Self.baseMult) + Self.basePow
        
        
        let doub = baseLog(Double(term))
        return Int(doub)
    }
    
    private func baseLog(_ number: Double) -> Double {
        return log(number) / log(Self.basePow)
    }
    
    
}
