//
//  NotesListView.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import SwiftUI
//import FirebaseFirestoreCombineSwift
import FirebaseFirestore
struct NotesListView: View {
    @StateObject var viewModel = NotesListViewModel()
    @FirestoreQuery var items: [NotesListItem]
    
    init(userId: String) {
        
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/notes")
        // Users/<id>/notes/<entrie#>
    }
    
    var body: some View {
        NavigationView {
            List(items) { item in
                NavigationLink(destination: NotesItemsView(item: item)) {
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.note.prefix(50) + "...")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                .listRowSpacing(20) // Adds spacing between list rows
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)) // Adjusts the row insets
            }
            .navigationTitle("Notes List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label : {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $viewModel.showingNewItemView) {
                    CreateNewItemView(newItemPresented: $viewModel.showingNewItemView)
                }
                .interactiveDismissDisabled(false)
            }
        }

    }
}

#Preview {
    NotesListView(userId: "GbkODCwDJ5fJsksWCacd286YkCK2")
}
