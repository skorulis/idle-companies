//  Created by Alexander Skorulis on 12/8/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct BasicMenuButton {
    
    let item: MenuButtonItem
    let action: () -> Void
}

// MARK: - Rendering

extension BasicMenuButton: View {
    
    var body: some View {
        Button(action: action) {
            HStack {
                item.icon.image(24)
                Text(item.name)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .contentShape(Rectangle())
        }
    }
}

// MARK: - Inner types

protocol MenuButtonItem {
    var icon: ThemeIcon { get }
    var name: String { get }
}

// MARK: - Previews

struct BasicMenuButton_Previews: PreviewProvider {
    
    static var previews: some View {
        BasicMenuButton(item: ConstructionSubType.buildings, action: {})
    }
}

