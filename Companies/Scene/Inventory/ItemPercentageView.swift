//  Created by Alexander Skorulis on 21/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemPercentageView {
    let item: ItemPercentage
}

// MARK: - Rendering

extension ItemPercentageView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ItemIconView(item: item.type)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black.opacity(0.3))
                )
            text
                .frame(minWidth: 24)
                .offset(y: 10)
        }
        .padding(.bottom, 10)
        .compositingGroup()
    }
    
    private var text: some View {
        Text(format(item.percent))
            .padding(.horizontal, 4)
            .foregroundColor(Color.black)
            .background(Capsule().fill(Color.gray))
    }
    
    func format(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = number < 0.01 ? 1 : 0
        return formatter.string(from: number as NSNumber)!
    }
}

// MARK: - Previews

struct ItemPercentageView_Previews: PreviewProvider {
    
    static var previews: some View {
        let item = ItemPercentage(type: .goldBar, percent: 0.33)
        ItemPercentageView(item: item)
    }
}


