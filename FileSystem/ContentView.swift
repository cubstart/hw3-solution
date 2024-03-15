//
//  ContentView.swift
//  FileSystem
//
//  Created by Andy Huang on 1/16/24.
//

import SwiftUI

struct ContentView: View {
    @State var files: [FileItem] = [
        FileItem(name: "Users", children:
          [FileItem(name: "guest", children:
            [FileItem(name: "Photos", children:
                        [FileItem(name: "photo001.jpg", contents: "")], contents: ""),
             FileItem(name: "Movies", children:
                        [FileItem(name: "movie001.mp4", contents: "")], contents: ""),
             FileItem(name: "Documents", children: [FileItem(name: "document.txt", contents: "")], contents: "")
            ], contents: ""),
          ], contents: ""),
        FileItem(name: "Shared", children: nil, contents: "")
      ]
    
    @State var addingFiles: Bool = false
    @State var selectedFile: FileItem?
    var body: some View {
        VStack {
            HStack {
                Text("Files")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(action: {addingFiles.toggle()}, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 30))
                        .foregroundStyle(.yellow)
                })
                .sheet(isPresented: $addingFiles, content: {AddFileItemView(files: $files)})
            }
            .padding()
            
            List(files, children: \.children) { file in
                if file.type != "folder" {
                    Button(action: {openFile(file: file)}, label: {
                        ListItemView(file: file)
                    })
                } else {
                    ListItemView(file: file)
                }
            }
            .sheet(item: $selectedFile) { file in
                EditFileView(file: file, files: $files)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func openFile(file: FileItem) {
        self.selectedFile = file
    }
}

struct ListItemView: View {
    var file: FileItem
    
    var body: some View {
        HStack {
            Image(systemName: file.type)
                .foregroundStyle(.yellow)
            Text("\(file.name)")
                .foregroundStyle(.white)
        }
        .font(.system(size: 20))
    }
}

#Preview {
    ContentView()
}

