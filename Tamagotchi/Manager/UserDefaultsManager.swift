//
//  UserDefaultsManager.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/22/24.
//

import Foundation

enum UserDefaultKey: String {
    case tamagotchi
    case user
}

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: UserDefaultKey
    let defaultValue: T
    let isCustomObject: Bool
    let ud = UserDefaults.standard
    
    var wrappedValue: T {
        get {
            if isCustomObject {
                guard let data = ud.object(forKey: key.rawValue) as? Data,
                      let value = try? JSONDecoder().decode(T.self, from: data) else {
                    return defaultValue
                }
                return value
            } else {
                return ud.object(forKey: key.rawValue) as? T ?? defaultValue
            }
        }
        
        set {
            if isCustomObject {
                let data = try? JSONEncoder().encode(newValue)
                ud.set(data, forKey: key.rawValue)
            } else {
                ud.set(newValue, forKey: key.rawValue)
            }
        }
    }
}

class UserDefaultsManager {
    
    // 싱글톤
    static let shared = UserDefaultsManager()
    private init() {}
    
    let ud = UserDefaults.standard
    
    // 데이터 초기화
    func removeAll() {
        ud.dictionaryRepresentation().keys.forEach { key in
            ud.removeObject(forKey: key)
        }
    }
    
    @UserDefault(key: .tamagotchi, defaultValue: nil, isCustomObject: true)
    static var tamagotchi: Tamagotchi?
    
    @UserDefault(key: .user, defaultValue: User(name: "유저"), isCustomObject: true)
    static var user: User?
}
