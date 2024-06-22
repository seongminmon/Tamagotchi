//
//  SceneDelegate.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        // 분기 처리
        // 선택한 다마고치와 유저 정보가 존재할 때
        if let tamagotchi = UserDefaultsManager.tamagotchi,
           let user = UserDefaultsManager.user {
            // 메인 화면
            let vc = MainViewController()
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        } else {
            // 선택 화면
            let vc = SelectViewController()
            vc.isSelect = true
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        }
        
        window?.backgroundColor = .backgroundColor
        window?.tintColor = .fontColor
        window?.makeKeyAndVisible()
    }
}
