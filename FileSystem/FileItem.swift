//
//  FileItem.swift
//  FileSystem
//
//  Created by Andy Huang on 1/18/24.
//

import Foundation

// DO NOT MODIFY
struct FileItem: Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var children: [FileItem]? = nil
    var contents: String
    var type: String {
        return getFileType(fileName: name)
    }
}
