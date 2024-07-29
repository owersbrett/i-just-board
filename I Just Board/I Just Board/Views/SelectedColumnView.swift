//
//  SelectedColumnView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation

import SwiftUI

struct SelectedColumnView: View {
    @State var column: BoardColumn
    let onSave: (BoardColumn) -> Void

    var body: some View {
        VStack {
            Text("Edit Column").font(.headline)

            TextField("Title", text: $column.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $column.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                debugPrint(column.name)
                onSave(column)
            }) {
                Text("Save")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
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
