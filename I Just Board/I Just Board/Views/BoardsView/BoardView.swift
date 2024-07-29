//
//  BoardView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import SwiftUI

struct BoardView:  View {
    @Binding var complexity: Complexity
    var board: Board
    
    func complexityLevel() -> String {
        var complexityString: String = "Complexity Level: ";
        if (complexity == .simple){
            complexityString += "Simple"
        } else if (complexity == .medium){
            complexityString += "Medium"
        } else if (complexity == .advanced){
            complexityString += "Advanced"
        }
        return complexityString;
    }

    var body: some View {
        VStack {
            Text(complexityLevel())
        }
    }
}
