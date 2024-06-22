//
//  Models.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/9/24.
//

import UIKit

struct Tamagotchi: Codable {
    var number: Int
    var riceCount: Int = 0
    var waterCount: Int = 0
    
    var level: Int {
        let value = Double(riceCount) / 5 + Double(waterCount) / 2
        switch value {
        case 0..<20: return 1
        case 20..<30: return 2
        case 30..<40: return 3
        case 40..<50: return 4
        case 50..<60: return 5
        case 60..<70: return 6
        case 70..<80: return 7
        case 80..<90: return 8
        case 90..<100: return 9
        default: return 10
        }
    }
    
    var name: String {
        switch number {
        case 1: return "따끔따끔 다마고치"
        case 2: return "방실방실 다마고치"
        case 3: return "반짝반짝 다마고치"
        default: return "준비중이에요"
        }
    }
    
    var image: UIImage? {
        return UIImage(named: "\(number)-\(level == 10 ? 9 : level)")
    }
    
    var firstImage: UIImage? {
        switch number {
        case 1...3:
            return UIImage(named: "\(number)-6")
        default:
            return UIImage(named: "noImage")
        }
    }
    
    var description: String {
        switch number {
        case 1:
            return """
            저는 선인장 다마고치입니다. 키는 2cm
            몸무게는 150g이에요.
            성격은 소심하지만 마음은 따뜻해요.
            열심히 잘 먹고 잘 클 자신은 있답니다.
            반가워요 주인님!!!
            """
        case 2:
            return """
            저는 방실방실 다마고치입니당 키는 100km
            몸무게는 150톤이에용 성격은 화끈하고 날라다닙니당~!
            열심히 잘 먹고 잘 클 자신은 있답니당 방실방실!
            """
        case 3:
            return """
            저는 반짝반짝 다마고치입니다. 키는 2cm
            몸무게는 150g이에요.
            성격은 소심하지만 마음은 따뜻해요.
            열심히 잘 먹고 잘 클 자신은 있답니다.
            반가워요 주인님!!!
            """
        default:
            return ""
        }
    }
    
}
