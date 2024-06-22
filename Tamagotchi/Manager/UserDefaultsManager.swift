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
    let ud = UserDefaults.standard
    
    var wrappedValue: T {
        get {
            guard let data = ud.object(forKey: key.rawValue) as? Data,
                  let value = try? JSONDecoder().decode(T.self, from: data) else {
                return defaultValue
            }
            return value
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            ud.set(data, forKey: key.rawValue)
        }
    }
}

class UserDefaultsManager {
    
    // 싱글톤
//    static let shared = UserDefaultsManager()
    private init() {}
//    let ud = UserDefaults.standard
    
    // 데이터 초기화
    static func removeAll() {
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    @UserDefault(key: .tamagotchi, defaultValue: nil)
    static var tamagotchi: Tamagotchi?
    
    @UserDefault(key: .user, defaultValue: User(name: "유저"))
    static var user: User?
}
