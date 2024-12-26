//
//  RegisterView.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var registerModel = RegisterViewModel()
    var body: some View {
        VStack {
            HeaderView(title: "Registeration", subtitle: "Enter info", angle: -15, background: .orange)
            Spacer()
            
            Form {
                TextField("Full Name", text: $registerModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email Address", text: $registerModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $registerModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                
                NotesButton(title: "Register", background: .green) {
                    //Attempt Registeration
                    
                    registerModel.register()
                }
                
            }
            .offset(y: -50)
            
            
        }
        
    }
}

#Preview {
    RegisterView()
}
