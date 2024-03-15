//
//  EditFileView.swift
//  FileSystem
//
//  Created by Andy Huang on 1/18/24.
//

import SwiftUI

struct EditFileView: View {
    enum FocusedField {
        case contents
    }
    @FocusState private var focusedField: FocusedField?
    
    @State var file: FileItem
    @Binding var files: [FileItem]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button(action: {print(updateContents(files: &files, filename: file.name, newContents: file.contents))}, label: {
                    Text("Save")
                        .font(.system(size: 20))
                        .foregroundStyle(.yellow)
                })
                .padding(.top)
                .padding(.trailing)
            }
            
            TextField("\(file.name)", text: $file.contents, axis: .vertical)
                .padding()
                .font(.system(size: 18))
                .focused($focusedField, equals: .contents)
                .onAppear {
                    focusedField = .contents
                }
            
            Spacer()
        }
        .presentationDetents([.fraction(0.8)])
    }
}

#Preview {
    ContentView()
}
