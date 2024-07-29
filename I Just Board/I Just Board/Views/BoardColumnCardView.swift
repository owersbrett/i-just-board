//
//  BoardColumnCardView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation
import SwiftUI

struct BoardColumnCardView: View {
    @EnvironmentObject var boardController: BoardController

    let card: Card
    init(card: Card) {
        self.card = card
        debugPrint("Initializing Card")
    }

    var body: some View {
        VStack {
                Text(card.name).font(.title)
                Text(card.description).font(.subheadline)
         
        }
    .padding()
        .background(Color.gray)
        .cornerRadius(8)
        .shadow(radius: 2)
        .onDrag {
            NSItemProvider(object: card.id.uuidString as NSString)
        }
    }
}
