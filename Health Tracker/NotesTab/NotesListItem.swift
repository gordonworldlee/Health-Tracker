//
//  NotesListItem.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import Foundation

struct NotesListItem: Codable, Identifiable {
    let id: String
    let userID: String
    let title: String
    let note: String
    let createdDate: TimeInterval
    var isDone: Bool
    let pdfURL: String?
    
    mutating func setDone(_ state:Bool) {
        isDone = state
    }
}
