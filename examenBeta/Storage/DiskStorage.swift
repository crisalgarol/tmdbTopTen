//
//  DiskStorage.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

public class DiskStorage {
    
    static func getURLOfDocuments() -> URL {
        
        let searchDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        if let url = FileManager.default.urls(for: searchDirectory, in: .userDomainMask).first {
            return url
        }
            
        fatalError("Can't create URL for specific directory")
    }
    
    static func saveToDisk<T: Encodable>(_ object: T, withName fileName: String) {
        
        let url = getURLOfDocuments().appendingPathComponent(fileName, isDirectory: false)
        let encoder = JSONEncoder()
        
        do {
            
            let data = try encoder.encode(object)
            
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch {
            fatalError(error.localizedDescription)
        }
        
    }
    
    static func getFromDisk<T: Decodable> (_ fileName: String, as type: T.Type) -> T? {
        
        let url = getURLOfDocuments().appendingPathComponent(fileName, isDirectory: false)

        if (!FileManager.default.fileExists(atPath: url.path)){
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
        
            let decoder = JSONDecoder()
            
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(url.path)")
        }
        
    }
    
    static func deleteFile(fileName: String) {
        
        let url = getURLOfDocuments().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do{
                try FileManager.default.removeItem(at: url)
            }catch {
                
            }
        }
        
    }
    
    static func fileExists(fileName: String) -> Bool {
        let url = getURLOfDocuments().appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: url.path)
    }
}
