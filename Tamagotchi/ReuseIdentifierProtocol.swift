//
//  ReuseIdentifierProtocol.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/8/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

//extension UIViewController: ReuseIdentifierProtocol {
//    static var identifier: String {
//        return String(describing: self)
//    }
//}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
