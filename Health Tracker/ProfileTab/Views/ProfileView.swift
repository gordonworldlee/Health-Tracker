//
//  ProfileView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/29/24.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                if let user = viewModel.user {
                    // Avatar
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                        .frame(width: 125, height: 125)
                        .padding()
                    
                    // Info about person
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Name: ")
                                .bold()
                            
                            Text(user.name)
                        }
                        .padding()
                        
                        HStack {
                            Text("Email: ")
                                .bold()
                            
                            Text(user.email)
                        }
                        .padding()
                        
                        HStack {
                            Text("Member since: ")
                                .bold()
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        }
                        .padding()
                    }
                    .padding()
                    
                    Button("Log Out") {
                        viewModel.logout()
                    }
                    .tint(.red)
                    .padding()
                    
                    Spacer()
                } else {
                    Text("Loading profile ...")
                    
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear() {
            viewModel.fetchUser()
        }
    }
}

#Preview {
    ProfileView()
}
