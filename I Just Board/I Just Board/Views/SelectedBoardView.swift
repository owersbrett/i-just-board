//
//  SelectedBoardView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation
import SwiftUI


struct SelectedBoardView: View {
    @State var board: Board
    let onSave: (Board) -> Void

    var body: some View {
        VStack {
            Text("Edit Board").font(.headline)

            TextField("Title", text: $board.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $board.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                onSave(board)
            }) {
                Text("Save")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding()
    }
}
