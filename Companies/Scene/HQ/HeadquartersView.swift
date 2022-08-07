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
            networth
            Text("Company HQ")
                .font(.title)
            hqBuilding
            Text("Enhancements")
                .font(.title)
            enhancements
        }
        .padding(.horizontal, 16)
    }
    
    private var hqBuilding: some View {
        VStack {
            Text(viewModel.hq.name)
            Text("\(viewModel.hq.inventorySpots) warehouse space")
            
            if let next = viewModel.hq.next {
                Button(action: viewModel.showUpgrade) {
                    HStack {
                        Text("Upgrade to \(next.name)")
                        Spacer()
                        upgradeIcon
                    }
                }
            }
        }
        .panelBackground()
    }
    
    @ViewBuilder
    private var upgradeIcon: some View {
        if viewModel.canUpgrade {
            Image(systemName: "checkmark.seal")
        } else {
            Image(systemName: "xmark.seal")
        }
    }
    
    private var enhancements: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Slots")
                Spacer()
                Text("\(viewModel.availableEnhancementSlots) / \(viewModel.totalEnhancementSlots)")
            }
            Button(action: viewModel.buyEnhancement) {
                Text("Purchase for \(viewModel.nextCostString)")
            }
            Button(action: viewModel.manageEnhancements) {
                Text("Manage")
            }
        }
        .panelBackground()
    }
    
    private var networth: some View {
        HStack {
            Text("Networth")
            Spacer()
            Text(ShortNumberFormatter.standard.format(viewModel.networth))
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

