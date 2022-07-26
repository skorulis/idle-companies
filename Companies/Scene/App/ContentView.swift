//
//  ContentView.swift
//  Companies
//
//  Created by Alexander Skorulis on 17/7/2022.
//

import SwiftUI
import ASKCore

struct ContentView: View {
    
    @Environment(\.factory) private var factory
    
    
}

// MARK: - Rendering

extension ContentView {
    
    var body: some View {
        ZStack {
            tabs
            ToastPresentationView(viewModel: factory.resolve())
                .allowsHitTesting(false)
        }
        
    }
    
    private var tabs: some View {
        TabView {
            operations
            inventory
            experiment
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
        NavigationStack {
            OperationListView(viewModel: factory.resolve())
        }
        .tabItem {
            Label("Operations", systemImage: "power.circle.fill")
        }
    }
    
    private var experiment: some View {
        CoordinatorView(coordinator: .init(factory: factory, root: .root))
            .tabItem {
                Text("Exp")
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
        ContentView()
    }
}
