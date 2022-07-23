//  Created by Alexander Skorulis on 23/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SkillProgressView {
    
    let xp: Int64
    let calc: XPLevelCalculation
    
}

// MARK: - Rendering

extension SkillProgressView: View {
    
    var body: some View {
        VStack {
            Text("Level: \(level)")
            Text("XP: \(xp) / \(nextXP)")
            LinearProgressView(progress: progressPct)
        }
    }
}

// MARK: - Computed values

private extension SkillProgressView {
    
    var level: Int {
        calc.level(xp)
    }
    
    var nextXP: Int64 {
        let l = level
        return calc.totalXP(l + 1)
    }
    
    var progressPct: CGFloat {
        let base = calc.totalXP(level)
        let next = nextXP
        let gap = next - base
        let value = xp - base
        return CGFloat(value) / CGFloat(gap)
    }
    
}

// MARK: - Previews

struct SkillProgressView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        VStack {
            SkillProgressView(xp: 500, calc: XPLevelCalculation())
            
            SkillProgressView(xp: 10, calc: XPLevelCalculation())
            SkillProgressView(xp: 70, calc: XPLevelCalculation())
            SkillProgressView(xp: 140, calc: XPLevelCalculation())
            
            SkillProgressView(xp: 112320, calc: XPLevelCalculation())
        }
        
    }
}
