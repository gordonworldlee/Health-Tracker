//
//  CreateNewItemViewModel.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation


class CreateNewItemViewModel: ObservableObject {
    @Published var title = ""
    @Published var noteText = ""
    @Published var showAlert = false
    @Published var pdfData: Data?
    @Published var pdfFileName: String?
    @Published var isSummarizing = false
    
    init() {

    }


    var characterCount: Int {
        return noteText.count
    }
    
    var wordCount: Int {
        return noteText.split(separator: " ").count
    }
    
    func save() {
       guard saveCheck else {
           return
       }
       
       guard let uId = Auth.auth().currentUser?.uid else {
           return
       }
       
       let newId = UUID().uuidString
       
       // If there's PDF data, upload it first
    
       let newItem = NotesListItem(
           id: newId,
           userID: uId,
           title: title,
           note: noteText,
           createdDate: Date().timeIntervalSince1970,
           isDone: false,
           pdfURL: nil
       )
       
       saveToFirestore(item: newItem, userId: uId)

    }
       
   private func saveToFirestore(item: NotesListItem, userId: String) {
       let db = Firestore.firestore()
       
       db.collection("users")
           .document(userId)
           .collection("notes")
           .document(item.id)
           .setData(item.asDictionary()) { error in
               if let error = error {
                   print("Error adding note: \(error)")
               }
           }
    }
    
    var saveCheck: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty,
              !noteText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
}
