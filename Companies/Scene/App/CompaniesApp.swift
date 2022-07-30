//
//  CompaniesApp.swift
//  Companies
//
//  Created by Alexander Skorulis on 17/7/2022.
//

import SwiftUI
import ASKCore

@main
struct CompaniesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    private let ioc = IOC(purpose: .normal)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.factory, ioc)
        }
    }
}
