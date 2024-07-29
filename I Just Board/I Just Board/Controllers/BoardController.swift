//
//  BoardController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import Combine

class BoardController: ObservableObject  {
    @Published var board: Board?
    private var cancellables = Set<AnyCancellable>()


    init(boardListController: BoardListController) {
        boardListController.$selectedBoard
            .assign(to: \.board, on: self)
            .store(in: &cancellables)
    }

    
    func changeBoardName(boardName: String)  {
        self.board?.boardName = boardName;
    }
    func changeBoardDescription(boardDescription: String){
        self.board?.boardDescription = boardDescription;
    }
    
    func addBoardColumn(boardColumn: BoardColumn){
        self.board?.boardColumns.append(boardColumn)
    }
    
}
