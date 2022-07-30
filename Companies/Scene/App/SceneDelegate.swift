//  Created by Alexander Skorulis on 31/7/2022.

import Foundation
import UIKit

final class SceneDelegate: NSObject, UISceneDelegate {
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Background")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("FOreground")
    }
    
    
}
