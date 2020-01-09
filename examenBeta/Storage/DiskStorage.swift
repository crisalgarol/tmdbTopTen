//
//  DiskStorage.swift
//  examenBeta
//
//  Created by Cristian Olmedo on 09/01/20.
//  Copyright © 2020 Cristian Olmedo. All rights reserved.
//

import Foundation

//This class is for Data persistence using JSON

public class DiskStorage {
    
    //Gets the URL of Documents Directory
    static func getURLOfDocuments() -> URL {
        
        let searchDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        if let url = FileManager.default.urls(for: searchDirectory, in: .userDomainMask).first {
            return url
        }
            
        fatalError("Can't create URL for specific directory")
    }
    
    //Save a Codable object to the disk in JSON format
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
    //Returns a Codable Object from the disk if is previously saved
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
    
    //Delete a file with a filname given
    static func deleteFile(fileName: String) {
        
        let url = getURLOfDocuments().appendingPathComponent(fileName, isDirectory: false)
        
        if FileManager.default.fileExists(atPath: url.path) {
            do{
                try FileManager.default.removeItem(at: url)
            }catch {
                
            }
        }
        
    }
    
    //Returns a boolean if a file exists
    static func fileExists(fileName: String) -> Bool {
        let url = getURLOfDocuments().appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: url.path)
    }
}
