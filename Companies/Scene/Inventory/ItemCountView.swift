//  Created by Alexander Skorulis on 20/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemCountView {
    let item: ItemCount
}

// MARK: - Rendering

extension ItemCountView: View {
    
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
    }
    
    private var text: some View {
        Text("\(item.count)")
            .padding(.horizontal, 4)
            .background(Capsule().fill(Color.gray))
    }
}

// MARK: - Previews

struct ItemCountView_Previews: PreviewProvider {
    
    static var previews: some View {
        let item = ItemCount(type: .goldBar, count: 40)
        ItemCountView(item: item)
    }
}

