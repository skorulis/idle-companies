//  Created by Alexander Skorulis on 12/8/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BattalionSummaryView {
    
    let battalion: Battalion
}

// MARK: - Rendering

extension BattalionSummaryView: View {
    
    var body: some View {
        VStack {
            ForEach(SoldierStat.allCases) { stat in
                statInfo(stat)
            }
            countRow
        }
        .panelBackground()
        //.frame(width: 100)
    }
    
    private var countRow: some View {
        HStack {
            ThemeIcon.person.image(20)
            Spacer()
            Text(ShortNumberFormatter.standard.format(battalion.count))
        }
    }
    
    private func statInfo(_ stat: SoldierStat) -> some View {
        HStack {
            stat.icon.image(20)
            Spacer()
            Text(text(stat))
        }
    }
    
    private func text(_ stat: SoldierStat) -> String {
        let value = battalion.value(stat)
        return ShortNumberFormatter.standard.format(value)
    }
    
    
}

// MARK: - Previews

struct BattalionSummaryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let bat = Battalion(stats: [.damage: 30,
            .accuracy: 1000], count: 5)
        return BattalionSummaryView(battalion: bat)
    }
}

