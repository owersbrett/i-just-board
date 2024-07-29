//
//  BoardCardView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftUI

struct BoardCardView: View {
    let board: Board

    var body: some View {
        VStack(alignment: .leading) {
            Text(board.name)
                .font(.headline)

            Text(board.description)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
