//
//  ContentView.swift
//  Viikkonumero
//
//  Created by Ruupert Koponen on 8.10.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAbout = false

    var body: some View {
        WeekCarouselView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background { WeekBackground().ignoresSafeArea() }
            .overlay(alignment: .topTrailing) { aboutButton }
            .sheet(isPresented: $isShowingAbout) {
                AboutView()
            }
    }

    private var aboutButton: some View {
        Button {
            isShowingAbout = true
        } label: {
            Image(systemName: "info.circle")
        }
        .labelStyle(.iconOnly)
        .buttonStyle(.glass)
        .buttonBorderShape(.circle)
        .controlSize(.large)
        .padding()
        .accessibilityLabel("About")
    }
}

#Preview {
    ContentView()
}
