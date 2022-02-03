//
//  CacheService.swift
//  Gradual
//
//  Created by Mason Dierkes on 2/3/22.
//

import Foundation
import EasyStash

class CacheService {
    
    var storage: Storage?
    var options: Options = Options()

    public init() {
        options.folder = "Data"
        storage = try? Storage(options: options)
    }
    
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
    
    func save<T>(data: T, forKey key: String) where T: Codable {
        DispatchQueue.global().async {
            do {
                try self.storage?.save(object: data, forKey: key)
                print("SAVED")
            } catch {
                print(error)
            }
        }
    }
    
    func save(data: String, forKey key: String) {
        DispatchQueue.global().async {
            do {
                try self.storage?.save(object: data, forKey: key)
                print("SAVED")
            } catch {
                print(error)
            }
        }
    }
    
    
    
    
}
