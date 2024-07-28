//
//  AddBoardButton.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

// AddBoardButton.swift
import SwiftUI

struct AddBoardButton: View {
    var action: () -> Void
    
    var body: some View {
        Button("Add Board") {
            self.action()
        }
        .padding()
        .buttonStyle(PlainButtonStyle())
    }
}
