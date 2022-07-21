//
//  ExperienceView.swift
//  Companies
//
//  Created by Alexander Skorulis on 22/7/2022.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct ExperienceView {
    
    let xp: Int64
}

// MARK: - Rendering

extension ExperienceView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "arrowtriangle.up.fill")
            Text("\(xp)")
        }
        .padding(2)
        .frame(minWidth: 40)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.1))
        )
    }
}

// MARK: - Previews

struct ExperienceView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            ExperienceView(xp: 100)
            ExperienceView(xp: 10)
        }
    }
}

