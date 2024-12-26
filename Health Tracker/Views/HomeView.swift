//
//  HomeView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/26/24.
//

import SwiftUI

struct HomeView: View {
    @State var calories: Int = 123
    @State var active: Int = 8
    @State var standing: Int = 50
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
                HStack {
                    
                    Spacer()
                    VStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Calories")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.red)
                            
                            Text("123 kcal")
                                .bold()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Active")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.green)
                            
                            Text("52 mins")
                                .bold()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stand")
                                .font(.callout)
                                .bold()
                                .foregroundColor(.blue)
                            
                            Text("8 hours")
                                .bold()
                        }
                        
                    }
                    
                    Spacer()
                    
                    ZStack {
                        ProgressCircleView(progress: $calories, color: .red, goal: 600)
                        ProgressCircleView(progress: $active, color: .green, goal: 60)
                            .padding(.all, 20)
                        ProgressCircleView(progress: $standing, color: .blue, goal: 100)
                            .padding(.all, 40)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .padding()
                
            }
        }
        
    }
}

#Preview {
    HomeView()
}
