//
//  NotesButton.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import SwiftUI

struct NotesButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .bold()
                    .foregroundColor(Color.white)
            }
        }
        .padding()
    }
}

#Preview {
    NotesButton(title: "Value", background: .blue) {
        
    }
}
