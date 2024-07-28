//
//  CurrentViewController.swift
//  I Just Board
//
//  Created by Brett Owers on 7/28/24.
//

import Foundation

class CurrentViewController: ObservableObject  {
    @Published var currentView: CurrentView = .boards

    func changeCurrentView(currentView: CurrentView)  {
        self.currentView = currentView;
    }
}
