//  Created by Alexander Skorulis on 28/7/2022.

import ASSwiftUI
import Foundation
import SwiftUI

// MARK: - Memory footprint

struct HeadquartersView {
    
    @StateObject var viewModel: HeadquartersViewModel
}

// MARK: - Rendering

extension HeadquartersView: View {
    
    var body: some View {
        PageTemplate(nav: nav, content: content)
    }
    
    private func nav() -> some View {
        NavBar(left: EmptyView(), mid: BarButtonItem.title("Headquarters"))
    }
    
    private func content() -> some View {
        VStack {
            Text(viewModel.name)
            hqBuilding
            
        }
        .padding(.horizontal, 16)
    }
    
    private var hqBuilding: some View {
        VStack {
            Text(viewModel.hq.name)
            Text("\(viewModel.hq.inventorySpots) warehouse space")
            
            if let next = viewModel.hq.next {
                Button(action: viewModel.showUpgrade) {
                    Text("Upgrade to \(next.name)")
                }
            }
        }
    }
}

// MARK: - Previews

struct HeadquartersView_Previews: PreviewProvider {
    
    static var previews: some View {
        let ioc = IOC()
        HeadquartersView(viewModel: ioc.resolve())
    }
}

