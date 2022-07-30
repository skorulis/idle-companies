//  Created by Alexander Skorulis on 31/7/2022.

import ASKCore
import Foundation
import UIKit

final class SceneDelegate: NSObject, UISceneDelegate {
    
    // No other way to share the object here
    static var factory: PFactory?
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        Self.factory?.resolveAll(type: PBackgroundListener.self).forEach { $0.didEnterBackground() }
        print("Background")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        Self.factory?.resolveAll(type: PBackgroundListener.self).forEach { $0.willEnterForeground() }
        print("FOreground")
    }
    
    
}
