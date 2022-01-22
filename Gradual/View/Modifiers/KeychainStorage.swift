//
//  KeychainStorage.swift
//  Gradual
//
//  Created by Mason Dierkes on 1/19/22.
//

import SwiftUI
import KeychainAccess

/// Syncs data between views and the Keychain storage.
@propertyWrapper
struct KeychainStorage: DynamicProperty {
    let key: String
    let keychain = Keychain(service: "credentials")
    
    @State private var value: String
    init(wrappedValue: String = "", _ key: String) {
        self.key = key
        let initialValue = (try? keychain.get(key)) ?? wrappedValue
        self._value = State<String>(initialValue: initialValue)
    }
    var wrappedValue: String {
        get  { value }
        nonmutating set {
            value = newValue
            do {
                try keychain.set(value, key: key)
            } catch let error {
                fatalError("\(error)")
            }
        }
    }
    var projectedValue: Binding<String> {
        Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
    }
}
