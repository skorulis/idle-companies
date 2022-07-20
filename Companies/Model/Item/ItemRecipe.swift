//  Created by Alexander Skorulis on 20/7/2022.

import Foundation

/// Recipe to make an item
struct ItemRecipe {
    
    let name: String
    let inputs: [ItemCount]
    let outputs: [ItemCount]
    
    init(name: String, inputs: [ItemCount], outputs: [ItemCount]) {
        self.name = name
        self.inputs = inputs
        self.outputs = outputs
    }
    
    init(output: ItemCount, inputs: [ItemCount]) {
        self.name = output.type.name
        self.inputs = inputs
        self.outputs = [output]
    }
    
    init(output: ItemType, inputs: [ItemCount]) {
        self.init(output: .init(type: output, count: 1), inputs: inputs)
    }
    
}


