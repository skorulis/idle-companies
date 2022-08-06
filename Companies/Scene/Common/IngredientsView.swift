//  Created by Alexander Skorulis on 28/7/2022.

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct IngredientsView {
 
    private let ingredients: [ItemCount]
    @ObservedObject private var inventory: InventoryStore
    
    @State private var presentedItem: ItemType?
    
    init(ingredients: [ItemCount], inventory: InventoryStore) {
        self.ingredients = ingredients
        _inventory = ObservedObject(wrappedValue: inventory)
    }
    
}

// MARK: - Rendering

extension IngredientsView: View {
    
    var body: some View {
        VStack {
            Text("Required")
            needed
            Text("You have")
            neededCounts
        }
        .sheet(item: $presentedItem) { item in
            ItemDetailsView(item: item, inv: inventory)
        }
    }
    
    private var needed: some View {
        HStack {
            ForEach(ingredients) { item in
                Button(action: showDetails(item)) {
                    ItemCountView(item: item, status: status(item))
                }
            }
        }
    }
    
    private var neededCounts: some View {
        HStack {
            ForEach(inputCounts) { item in
                Button(action: showDetails(item)) {
                    ItemCountView(item: item)
                }
            }
        }
    }
    
    private func status(_ item: ItemCount) -> ItemCountView.Status {
        inventory.contains(item: item) ? .normal : .missing
    }
    
    var inputCounts: [ItemCount] {
        return ingredients.map { item in
            return ItemCount(type: item.type, count: inventory.count(item: item.type))
        }
    }
}

// MARK: - Logic

private extension IngredientsView {
    
    func showDetails(_ item: ItemCount) -> () -> Void {
        return {
            self.presentedItem = item.type
        }
    }
    
}

// MARK: - Previews

struct IngredientsView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        let inv: InventoryStore = ioc.resolve()
        let items: [ItemCount] = [
            .init(type: .goldBar, count: 10),
            .init(type: .ironBar, count: 20),
        ]
        return IngredientsView(ingredients: items, inventory: inv)
    }
}

