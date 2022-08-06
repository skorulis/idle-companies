//  Created by Alexander Skorulis on 17/7/2022.

import Foundation

struct OperationProgress: Codable {
    
    enum CodingKeys: String, CodingKey {
        case operation
        case operationType
        case timing
    }
    
    let operation: any POperation
    let timing: TaskTiming
    var timer: Timer?
    
    var finishTime: TimeInterval { timing.finishTime }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(timing, forKey: .timing)
        let typeName = String(describing: type(of: operation))
        try container.encode(typeName, forKey: .operationType)
        try container.encode(operation, forKey: .operation)
    }
    
    init<T: POperation>(operation: T, timing: TaskTiming) {
        self.operation = operation
        self.timing = timing
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.timing = try container.decode(TaskTiming.self, forKey: .timing)
        let typeName = try container.decode(String.self, forKey: .operationType)
        self.operation = try Self.decode(operationType: typeName, container: container)
    }
}


private extension OperationProgress {
    
    static func decode(operationType: String,
                       container: KeyedDecodingContainer<OperationProgress.CodingKeys>
    ) throws -> any POperation {
        switch operationType {
        case "MiningActivity":
            return try container.decode(MiningActivity.self, forKey: .operation)
        case "MarketingActivity":
            return try container.decode(MarketingActivity.self, forKey: .operation)
        case "SmeltingActivity":
            return try container.decode(SmeltingActivity.self, forKey: .operation)
        case "ConstructionContractActivity":
            return try container.decode(ConstructionContractActivity.self, forKey: .operation)
        case "ConstructionMaterialActivity":
            return try container.decode(ConstructionMaterialActivity.self, forKey: .operation)
        case "RecruitingActivity":
            return try container.decode(RecruitingActivity.self, forKey: .operation)
        default:
            fatalError("Could not decode \(operationType)")
        }
    }
    
}
