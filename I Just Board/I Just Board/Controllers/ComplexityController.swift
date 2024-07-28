//
//  ComplexityController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation
class ComplexityController: ObservableObject  {
    @Published var complexity: Complexity = .simple

    func changeComplexity(complexity: Complexity)  {
        self.complexity = complexity;
    }
}
