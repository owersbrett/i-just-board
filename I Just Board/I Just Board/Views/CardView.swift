//
//  BoardColumnCardView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    @EnvironmentObject var boardController: BoardController
    @EnvironmentObject var windowSize: WindowSize
    
    @Binding var card: Card
    var body: some View {
        VStack {
            EditableTextField(text: $card.name, onSubmit: {
                newValue in
                var updatedCard = card
                updatedCard.name = newValue
                boardController.updateCard(updatedCard)
            }, fontSize: 16)
            Text("\(card.index)")  // Convert Int to String
            if (!card.description.isEmpty){
                EditableTextField(text: $card.description, onSubmit: {
                    newValue in
                    var updatedCard = card
                    updatedCard.description = newValue
                    boardController.updateCard(updatedCard)
                })
            }
        }        .frame(width: windowSize.size.width * 0.15, alignment: .leading)
            

//    .padding()
        .background(Color.indigo)
        .cornerRadius(8)
        .shadow(radius: 2)
        .onDrag {
            NSItemProvider(object: card.id.uuidString as NSString)
        }
    }
}
