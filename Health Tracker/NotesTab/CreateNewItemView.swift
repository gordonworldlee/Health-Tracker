//
//  CreateNewItemView.swift
//  NotesApp
//
//  Created by Gordon Lee on 12/22/24.
//

import SwiftUI

struct CreateNewItemView: View {
    @StateObject var viewModel = CreateNewItemViewModel()
    @Environment(\.dismiss) var dismiss
    @Binding var newItemPresented: Bool
    @State private var showingFilePicker = false
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
            VStack {
                Text("New Item")
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top, 20)
                
                Form {
                    // Title
                    Section(header: Text("Title")) {
                        TextField("Title", text: $viewModel.title)
                    }
                    
                    // Text
                    Section(header: Text("Note Content")) {
                        TextEditor(text: $viewModel.noteText)
                            .frame(minHeight: 300)
                            .font(.body)
                    }
                    // Statistics
                    Section(header: Text("Statistics")) {
                        HStack {
                            Text("Characters: \(viewModel.characterCount)")
                            Spacer()
                            Text("Words: \(viewModel.wordCount)")
                        }
                        .font(.caption)
                    }
                    
                    // Save Button
                    NotesButton(title: "Save", background: .pink) {
                        if viewModel.saveCheck {
                            viewModel.save()
                            newItemPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Error"), message: Text("Empty field"))
                    }
                }
            }
            .fileImporter(
                isPresented: $showingFilePicker,
                allowedContentTypes: [.pdf]
            ) { result in
                switch result {
                case .success(let url):
                    do {
                        let data = try Data(contentsOf: url)
                        viewModel.pdfData = data
                        viewModel.pdfFileName = url.lastPathComponent
                        print("PDF attached successfully: \(url.lastPathComponent)")
                    } catch {
                        print("Error loading PDF: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Error selecting PDF: \(error.localizedDescription)")
                }
            }
        }
}

#Preview {
    CreateNewItemView(newItemPresented: Binding( get: {
        return true
    }, set: { _ in
        
    }))
}
