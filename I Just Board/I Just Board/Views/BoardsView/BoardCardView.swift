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
            Text(board.boardName)
                .font(.headline)

            Text(board.boardDescription)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
