//
//  LoginViewModel.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    func login() {
        guard validate() else {
            return
        }

        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            errorMessage = "Please fill in the form"
            return false
        }
        
        // Validate email
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        return true
    }
}
