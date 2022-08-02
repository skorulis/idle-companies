//  Created by Alexander Skorulis on 2/8/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct RecipeOutputView {
    
    let item: ItemType
    @ObservedObject var inv: InventoryStore
}

// MARK: - Rendering

extension RecipeOutputView: View {
    
    var body: some View {
        HStack {
            outputCountView
            rightTop
        }
    }
    
    private var rightTop: some View {
        VStack(alignment: .leading) {
            Text("Create")
            Spacer()
                .layoutPriority(-1)
            Text(item.name)
        }
        .panelBackground()
    }
    
    private var outputCountView: some View {
        VStack {
            ItemIconView(item: item)
            Text("\(outputCount)")
        }
        .padding(4)
        .background(PanelBackground())
    }
    
    var outputCount: Int {
        inv.count(item: item)
    }
}

// MARK: - Previews

struct RecipeOutputView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        ScrollView {
            RecipeOutputView(item: .goldBar, inv: ioc.resolve())
        }
    }
}

