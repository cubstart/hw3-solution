//
//  AddFileItemView.swift
//  FileSystem
//
//  Created by Andy Huang on 1/16/24.
//

import SwiftUI

struct AddFileItemView: View {
    @Environment(\.dismiss) var dismissSheet
    @Binding var files: [FileItem]
    
    @State var selectedFileName: String = ""
    @State var selectedFileType: String = "Folder"
    @State var selectedDirectory: String = "root"
    
    var directories: [String] {
        return ["root"] + getDirectoryNames(files: files)
    }
    
    let fileTypes: [String] = ["Folder", "Text", "Image", "Video"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Add File")
                    .font(.system(size: 25))
                    .bold()
                
                Spacer()
            }
            .padding(20)
            
            HStack(alignment: .bottom, spacing: 0) {
                TextField(text: $selectedFileName, label: {Text("File name")})
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth:2)
                )
                .padding(.top, 20)
                .padding(.leading, 20)
                .padding(.trailing, 5)
                
                Picker("Location", selection: $selectedDirectory) {
                    ForEach(directories, id: \.self) {
                        Text($0)
                            .foregroundStyle(.yellow)
                    }
                }
            }
                
            Picker("File Types", selection: $selectedFileType) {
                ForEach(fileTypes, id: \.self) {
                    Text($0)
                }
            }
            .foregroundStyle(.yellow)
            .pickerStyle(.segmented)
            .padding()
            
            Button {
                print(insertNewFile(files: &files, parentDirectoryName: selectedDirectory, newFile: FileItem(name: "\(selectedFileName)\(resolveFileExtension(type: selectedFileType))", contents: "")))
                dismissSheet()
            } label: {
                Text("Add")
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .padding()
            
            Spacer()
        }
        .presentationDetents([.fraction(0.4)])
    }
}

#Preview {
    ContentView()
}
