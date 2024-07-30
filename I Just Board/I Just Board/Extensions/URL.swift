//
//  URL.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation

extension URL {
    static var boardsFile: URL {
        return FileManager.documentsDirectory.appendingPathComponent("boards.json")
    }
}
