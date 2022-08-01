//
//  ContentView.swift
//  Companies
//
//  Created by Alexander Skorulis on 17/7/2022.
//

import SwiftUI
import ASKCore

struct ContentView: View {
    
    private let factory: PFactory
    @ObservedObject private var changeService: ChangeHistoryService
    
    init(factory: PFactory) {
        self.factory = factory
        _changeService = ObservedObject(wrappedValue: factory.resolve(ChangeHistoryService.self))
    }
    
}

// MARK: - Rendering

extension ContentView {
    
    var body: some View {
        ZStack {
            tabs
            ToastPresentationView(viewModel: factory.resolve())
                .allowsHitTesting(false)
        }
        .sheet(item: $changeService.toDispay) { change in
            ChangeHistoryView(viewModel: factory.resolve())
        }
    }
    
    private var tabs: some View {
        TabView {
            operations
            inventory
            headquarters
            #if DEBUG
            debug
            #endif
        }
    }
    
    private var inventory: some View {
        NavigationView {
            InventoryView(viewModel: factory.resolve())
        }
        .tabItem {
            Label("Warehouse", systemImage: "archivebox")
        }
    }
    
    private var operations: some View {
        CoordinatorView(coordinator: .init(factory: factory, root: .operation(.list)))
            .tabItem {
                Label("Operations", systemImage: "power.circle.fill")
            }
    }
    
    private var headquarters: some View {
        CoordinatorView(coordinator: .init(factory: factory, root: .hq(.home)))
            .tabItem {
                Label("Headquarters", systemImage: "flag.fill")
            }
    }
    
    #if DEBUG
    private var debug: some View {
        NavigationView {
            DebugView(viewModel: factory.resolve())
        }
        .tabItem {
            Label("Debug", systemImage: "ladybug.fill")
        }
    }
    #endif
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let ioc = IOC()
        ContentView(factory: ioc)
    }
}
