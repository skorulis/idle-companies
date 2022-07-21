//  Created by Alexander Skorulis on 20/7/2022.

import Foundation

// MARK: - Memory footprint

/// Recipe to make an item
public struct ItemRecipe {
    
    public let name: String
    public let inputs: [ItemCount]
    public let outputs: [ItemCount]
    
    public init(name: String, inputs: [ItemCount], outputs: [ItemCount]) {
        self.name = name
        self.inputs = inputs
        self.outputs = outputs
    }
    
    public init(inputs: [ItemCount], output: ItemCount) {
        self.name = output.type.name
        self.inputs = inputs
        self.outputs = [output]
    }
    
    public init(inputs: [ItemCount], output: ItemType) {
        self.init(inputs: inputs, output: .init(type: output, count: 1))
    }
    
}

// MARK: - Logic

extension ItemRecipe: Identifiable {
    
    public var id: String { name }
    
    var outputPercentages: [ItemPercentage] {
        let total: Double = outputs.reduce(0) { partialResult, item in
            return partialResult + Double(item.count)
        }
        return outputs.map { item in
            return ItemPercentage(type: item.type, percent: Double(item.count) / total)
        }
    }
    
}
