//
//  ContentView.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import SwiftUI
import SwiftData



struct ContentView: View {
    @State private var complexity: Complexity = .simple
    @State private var currentView: CurrentView = .boards
    @State private var showMenu = false
    @State private var board = Board.init(boardName: "New Board", boardDescription: "Describe your new board")
    @State private var card = Card.init(cardName: "New Card", cardDescription: "Describe card")
    @StateObject var boardListController: BoardListController
    @StateObject var currentViewController: CurrentViewController



    
    
    
    var body: some View {
        VStack {
         
            switch currentViewController.currentView {
            case .boards:
                 BoardsView(title: "Boards", complexity: $complexity, boardListController: boardListController)
            case .board:
                 BoardView(complexity: $complexity, board: board)
            case .card:
                 CardView(complexity: $complexity, card: card)
            }
            // Your main content here
//            BoardsView(title: "Boards", complexity: $complexity)
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(boardListController: BoardListController.init(), currentViewController: CurrentViewController.init())
    }
}
