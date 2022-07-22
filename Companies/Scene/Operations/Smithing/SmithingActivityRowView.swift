//
//  SmithingActivityRowView.swift
//  Companies
//
//  Created by Alexander Skorulis on 22/7/2022.
//

import Foundation
import SwiftUI

// MARK: - Memory footprint

struct SmithingActivityRowView {
    let activity: SmithingActivity
}

// MARK: - Rendering

extension SmithingActivityRowView: View {
    
    var body: some View {
        HStack {
            icon
            Text(activity.name)
            Spacer()
        }
    }
    
    private var icon: some View {
        activity.output.icon
            .image(20)
    }
}

// MARK: - Previews

struct SmithingActivityRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        SmithingActivityRowView(activity: SmithingActivity.concrete)
    }
}

