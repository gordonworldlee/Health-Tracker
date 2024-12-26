//
//  HeaderView.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees:angle))
                
            VStack {
                Text(title)
                    .font(.system(size:50))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                
                Text(subtitle)
                    .foregroundColor(Color.white)
                    .font(.system(size:30))
            }
            .padding(.top, 80)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y: -150)
    }
}

#Preview {
    HeaderView(title: "Title", subtitle: "subtitle", angle: -15, background: .blue)
}
