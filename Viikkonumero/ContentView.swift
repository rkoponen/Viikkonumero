//
//  ContentView.swift
//  Viikkonumero
//
//  Created by Ruupert Koponen on 8.10.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WeekCarouselView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background { WeekBackground().ignoresSafeArea() }
    }
}

#Preview {
    ContentView()
}
