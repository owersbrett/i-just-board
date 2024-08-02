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
    @EnvironmentObject var themeController: ThemeController
    @Binding var card: Card

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                EditableTextField(text: $card.name, onSubmit: { newValue in
                    var updatedCard = card
                    updatedCard.name = newValue
                    boardController.updateCard(updatedCard)
                }, fontSize: 16)
                
            }
            .padding([.trailing])
            .frame(width: windowSize.size.width * 0.15, alignment: .leading)
            .background( themeController.currentTheme.cardBackgroundColor)
            .cornerRadius(20)
            .shadow(radius: 2)
            .onDrag {
                NSItemProvider(object: card.id.uuidString as NSString)
            }
            
        }
    }
}
