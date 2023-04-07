//
//  EmptyContentView.swift
//  TidalChallenge
//
//  Created by Zofia Drabek on 07.04.23.
//

import SwiftUI

struct EmptyContentView<Content: View>: View {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(spacing: 8) {
            content()
        }
        .multilineTextAlignment(.center)
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundStyle(.secondary)
        .imageScale(.large)
    }
}
