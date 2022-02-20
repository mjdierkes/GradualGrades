//
//  CacheService.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import Foundation
import EasyStash

/// A custom wrapper class to interface with the Cache Storage.
class CacheService {
    
    var storage: Storage?
    var options: Options = Options()

    /// All cached information stored in the "Data" folder.
    /// Use this folder when accessing the cached values.
    public init() {
        options.folder = "Data"
        storage = try? Storage(options: options)
    }
    
    /// Pulls an object of requested type from the folder.
    /// This is used when accessing any stored information.
    func load<T>(forKey key: String) -> T? where T: Codable {
        do {
            if let storage = storage {
                let loadedData: T = try storage.load(forKey: key, as: T.self)
                return loadedData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    /// Attempts to save an object to disk.
    /// This will fail of the options folder does not exist.
    func save<T>(data: T, forKey key: String) where T: Codable {
        DispatchQueue.global().async {
            do {
                try self.storage?.save(object: data, forKey: key)
            } catch {
                print(error)
            }
        }
    }
    
}
