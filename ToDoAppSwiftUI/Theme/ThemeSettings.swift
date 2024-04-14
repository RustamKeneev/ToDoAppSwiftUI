//
//  ThemeSettings.swift
//  ToDoAppSwiftUI
//
//  Created by Rustam Keneev on 13/4/24.
//

import SwiftUI

//MARK: - THEME CLASS
class ThemeSettings: ObservableObject{
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme"){
        didSet{
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}

