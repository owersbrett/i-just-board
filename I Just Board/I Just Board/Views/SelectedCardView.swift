//
//  SelectedCardView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation

import SwiftUI

struct SelectedCardView: View {
    @State var card: Card
    let onSave: (Card) -> Void
    let onCancel: (Card) -> Void

    var body: some View {
        VStack {
            Text("Edit Card").font(.headline)

            TextField("Title", text: $card.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $card.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            HStack{
                Button(action: {
                    onCancel(card)
                }) {
                    Text("Cancel")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                Button(action: {
                    debugPrint("Updating Card")
                    debugPrint(card.name)
                    debugPrint(card.description)
                    onSave(card)
                }) {
                    Text("Save")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding()
    }
}
