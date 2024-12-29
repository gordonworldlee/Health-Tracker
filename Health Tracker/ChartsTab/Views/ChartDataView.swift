//
//  ChartDataView.swift
//  Health Tracker
//
//  Created by Gordon Lee on 12/28/24.
//

import SwiftUI

struct ChartDataView: View {
    @State var average: Int
    @State var total: Int
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Average")
                    .font(.title2)
                Text("\(average)")
                    .font(.title3)
            }
            .frame(width: 90)
            .foregroundColor(.black)
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
            
            
            
            Spacer()
            VStack {
                Text("Total")
                    .font(.title2)
                Text("\(total)")
                    .font(.title3)
            }
            .frame(width: 80)
            .foregroundColor(.black)
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
            
            
            Spacer()
        }
    }
}

#Preview {
    ChartDataView(average: 123345, total: 123234)
}
