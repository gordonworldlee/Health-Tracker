//
//  NotesItemsView.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import SwiftUI

struct NotesItemsView: View {
    let item: NotesListItem
    @StateObject var viewModel = NotesItesmViewViewModel()
    let formatter: DateFormatter
    @Environment(\.dismiss) private var dismiss
    
    init(item: NotesListItem) {
        self.item = item
        self.formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title Section
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text(formatter.string(from: Date(timeIntervalSince1970: item.createdDate)))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .padding(.vertical, 8)
                
                Text(item.note)
                    .font(.body)
                    .lineSpacing(8)
                    .foregroundColor(.primary.opacity(0.9))
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 30)
        }
        .background(Color(.systemBackground))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Add delete functionality here
                    viewModel.delete(userID: item.userID, notesid: item.id)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            
        }
    }

}

#Preview {
    NavigationView {
        NotesItemsView(item: NotesListItem(
            id: "1",
            userID: "4",
            title: "Sample Note",
            note: "Lorem Ipsum...",
            createdDate: Date().timeIntervalSince1970,
            isDone: false,
            pdfURL: nil
        ))
    }
}
