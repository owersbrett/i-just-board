//
//  BoardColumnView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftUI

struct BoardColumnView: View {
    let column: BoardColumn

    var body: some View {
        VStack {
            Text(column.name).font(.headline)
            // Add card views here
        }
        .frame(width: 200)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}
