//
//  SettingsView.swift
//  ToDo
//
//  Created by Labhesh Dudi on 17/09/25.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTIES
    @State private var count: Int = 0
    @State private var value = 0.0
    @State private var isEditing: Bool = false
    @State private var segmentedControlIndex: Int = 1
    @State private var selectedColor: Color = .cyan
    @State private var selectedDate: Date = .now
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                
                Form {
                    Text("Hello world!")
                }//: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                //MARK: - Footer
                Text("All rights reserved. © 2025 Labhesh Dudi.\n Better Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }//: VSTACK
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

// MARK: - Preview

#Preview {
    SettingsView()
}
