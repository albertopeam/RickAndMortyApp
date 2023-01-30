//
//  UserDefaultsMock.swift
//  RickAndMortyAppTests
//
//  Created by albertopeam on 2/2/23.
//

import Foundation

final class UserDefaultsMock: UserDefaults {
    var getBoolKey: String?
    var setBoolKey: String?
    var setBoolValue: Bool? = nil
    
    override func bool(forKey defaultName: String) -> Bool {
        getBoolKey = defaultName
        return false
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        setBoolKey = key
        setBoolValue = value as? Bool
    }
}
