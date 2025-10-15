//
//  ThemeSettings.swift
//  ToDo
//
//  Created by Labhesh Dudi on 15/10/25.
//

import SwiftUI

// MARK: - THEME CLASS

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(themeSettings, forKey: "Theme")
        }
    }
}
