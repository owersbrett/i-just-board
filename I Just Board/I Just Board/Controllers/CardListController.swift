//
//  CardsController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

class CardListController: ObservableObject  {
    @Published var cards: [Card] = []

    func addCard(cardName: String, cardDescription: String)  {
        var card: Card = Card(cardName: cardName, cardDescription: cardDescription)
        self.cards.append(card)
    }
}
