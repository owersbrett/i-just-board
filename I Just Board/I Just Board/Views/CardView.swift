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
    
    let card: Card
    var body: some View {
        VStack {
            Text(card.name).font(.title).frame(alignment: .leading)
            if (!card.description.isEmpty){
                Text(card.description).font(.subheadline).frame(alignment: .leading)
            }
        }        .frame(width: windowSize.size.width * 0.15, alignment: .leading)
            

    .padding()
        .background(Color.gray)
        .cornerRadius(8)
        .shadow(radius: 2)
        .onDrag {
            NSItemProvider(object: card.id.uuidString as NSString)
        }
    }
}
