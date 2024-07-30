//
//  FileManager.swift
//  I Just Board
//
//  Created by Brett Owers on 7/29/24.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    static func deleteBoardsFile() throws {
            let fileURL = URL.boardsFile
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(at: fileURL)
            }
        }
}
