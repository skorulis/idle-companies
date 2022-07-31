//  Created by Alexander Skorulis on 21/7/2022.

import Foundation
import SwiftUI

/// Protocol to provide information about time
public protocol PTimeProvider {
    
    /// Current time
    var time: Date { get }
    
    /// Speed the game is running at
    var speed: TimeInterval { get }
}

extension PTimeProvider {
    
    var seconds: TimeInterval { time.timeIntervalSince1970 }
}

public final class TimeProvider: PTimeProvider {
    
    public var time: Date {
        return Date()
    }
    
    public var speed: TimeInterval {
        return 1
    }
    
}

public struct TimeProviderKey: EnvironmentKey {
    public static var defaultValue: PTimeProvider = TimeProvider()
}

extension EnvironmentValues {
    
    var timeProvider: PTimeProvider {
        get { self[TimeProviderKey.self] }
        set { self[TimeProviderKey.self] = newValue }
    }
}

