//  Created by Alexander Skorulis on 1/8/2022.

import ASKCore
import Foundation
import UIKit
import SwiftUI

final class ToastPresentationWindow: UIWindow {
    
    private let factory: PFactory
    
    init(factory: PFactory) {
        self.factory = factory
        super.init(frame: UIScreen.main.bounds)
        setup()
    }
    
    private func setup() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            self.windowScene = scene
        }
        
        let rootView = ToastPresentationView(viewModel: self.factory.resolve())
        self.rootViewController = UIHostingController(rootView: rootView)
        self.rootViewController?.view.backgroundColor = UIColor.clear
        self.rootViewController?.view.isUserInteractionEnabled = false
        self.windowLevel = UIWindow.Level.alert + 1
        self.backgroundColor = .clear
        self.makeKeyAndVisible()
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
