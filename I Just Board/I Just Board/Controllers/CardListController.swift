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
        let card: Card = Card.createDefault()
        self.cards.append(card)
    }
}
