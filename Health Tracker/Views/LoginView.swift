//
//  LoginView.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                //Header
                HeaderView(title: "Notes", subtitle: "Efficiency is key", angle: 0, background: .pink)
                
                //Login Form
 
                Form {
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    NotesButton(title: "Log in", background: .blue) {
                        //Attempt login
                        viewModel.login()
                        
                    }
                }
                .offset(y: -50)
                
                //Create Account
                VStack {
                    Text("New user?")
                    NavigationLink("Create an account", destination: RegisterView())
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
        
        
    }
}

#Preview {
    LoginView()
}
