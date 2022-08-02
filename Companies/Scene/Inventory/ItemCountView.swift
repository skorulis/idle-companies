//  Created by Alexander Skorulis on 20/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ItemCountView {
    let item: ItemCount
    let status: Status
    
    init(item: ItemCount, status: Status = .normal) {
        self.item = item
        self.status = status
    }
}

// MARK: - Rendering

extension ItemCountView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ItemIconView(item: item.type)
                .padding(8)
                .background(background)
            text
                .frame(minWidth: 24)
                .offset(y: 10)
        }
        .padding(.bottom, 10)
    }
    
    private var background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.black.opacity(0.3))
            if status == .missing {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.red)
            }
        }
        
    }
    
    private var text: some View {
        Text(item.shortCountText)
            .padding(.horizontal, 4)
            .background(Capsule().fill(Color.gray))
            .foregroundColor(.black)
    }
}

// MARK: - Inner types

extension ItemCountView {
    
    enum Status {
        case normal
        case missing
    }
    
}

// MARK: - Previews

struct ItemCountView_Previews: PreviewProvider {
    
    static var previews: some View {
        let item = ItemCount(type: .goldBar, count: 40)
        HStack {
            ItemCountView(item: item)
            ItemCountView(item: item, status: .missing)
        }
        
    }
}

