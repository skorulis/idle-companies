//  Created by Alexander Skorulis on 30/7/2022.

import Foundation

protocol PActivityService {
    associatedtype ActivityType: POperation
    associatedtype StatsType: PActivityStats
    
    func stats(activity: ActivityType) -> StatsType
    
    func tryStart(activity: ActivityType) throws
    func finish(activity: ActivityType) throws 
    
}

extension PActivityService {
    
    func tryStart(activity: ActivityType) throws { /* Do nothing */ }
}
