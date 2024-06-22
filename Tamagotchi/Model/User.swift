//
//  User.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/22/24.
//

import Foundation

struct User: Codable {
    var name: String
    
    var message: [String] {
        return [
            "\(name)님, 밥주세요",
            "\(name)님, 좋은 하루 보내세요.",
            "안녕하세요. \(name)님",
            "밥과 물을 잘 먹었더니 레벨업했어요. 고마워요 \(name)님"
        ]
    }
}
