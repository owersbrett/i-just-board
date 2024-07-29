//
//  GridOfBoards.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
import SwiftUI


struct GridOfBoardsView: View {
    @Binding var boards: [Board]
    
    var body: some View {

        LazyVGrid(columns: [GridItem.init()]) {
            if (boards.isEmpty) {
 
                AddBoardButton()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ForEach(boards.indices, id: \.self) { index in
                    if index < boards.count {
                        BoardCardView(board: boards[index])
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        AddBoardButton()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            
        }
    }
}
