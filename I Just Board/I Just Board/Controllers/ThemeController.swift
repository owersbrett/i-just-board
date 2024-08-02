//
//  ThemeController.swift
//  I Just Board
//
//  Created by Brett Owers on 8/1/24.
//

import SwiftUI
import Combine

class ThemeController: ObservableObject {
    static let shared = ThemeController()
    
    @Published var currentTheme: Theme = DarkTheme()
    
    func switchTheme(to theme: Theme) {
        self.currentTheme = theme
    }
}

protocol Theme {
    var boardBackgroundColor: Color { get }
    var columnBackgroundColor: Color { get }
    var cardBackgroundColor: Color { get }
    var addCardColor: Color { get }
    var addColumnColor: Color { get }
    var addBoardColor: Color { get }
    var addCardFontColor: Color { get }
    // Add more color properties as needed
}

struct LightTheme: Theme {
    let boardBackgroundColor = Color(red: 0.95, green: 0.95, blue: 0.95) // Light gray
    let columnBackgroundColor = Color(red: 0.9, green: 0.9, blue: 0.95) // Soft blue-gray
    let cardBackgroundColor = Color(red: 0.98, green: 0.98, blue: 1.0) // Very light blue
    let addCardColor = Color(red: 0.3, green: 0.7, blue: 0.4) // Green
    let addColumnColor = Color(red: 0.2, green: 0.5, blue: 0.8) // Blue
    let addBoardColor = Color(red: 0.9, green: 0.4, blue: 0.4) // Soft red
    let addCardFontColor = Color(red: 0.95, green: 0.95, blue: 0.95)
}

struct DarkTheme: Theme {
    let boardBackgroundColor = Color(red: 0.1, green: 0.1, blue: 0.1) // Dark gray
    let columnBackgroundColor = Color(red: 0.15, green: 0.15, blue: 0.2) // Dark blue-gray
    let cardBackgroundColor = Color(red: 0.2, green: 0.2, blue: 0.25) // Darker blue-gray
    let addCardColor = Color(red: 0.5, green: 0.8, blue: 0.6) // Light green
    let addColumnColor = Color(red: 0.4, green: 0.6, blue: 0.9) // Light blue
    let addBoardColor = Color(red: 0.8, green: 0.4, blue: 0.4) // Light red
    let addCardFontColor = Color(red: 0.1, green: 0.1, blue: 0.1) // Dark gray

}
