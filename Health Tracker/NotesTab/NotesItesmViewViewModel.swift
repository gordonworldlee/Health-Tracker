//
//  NotesItesmViewViewModel.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import Foundation
import FirebaseFirestore

class NotesItesmViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    init() {
        
    }
    
    func delete(userID: String, notesid: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userID)
            .collection("notes")
            .document(notesid)
            .delete() { error in
                if let error = error {
                    print("Error deleting: \(error)")
                }
            }
        
    }
}
