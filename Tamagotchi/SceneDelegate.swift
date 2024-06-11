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
        if let savedData = UserDefaults.standard.object(forKey: "tamagotchi") as? Data {
            if let savedTamagotchi = try? JSONDecoder().decode(Tamagotchi.self, from: savedData) {
                // 선택된 다마고치가 있을 때 -> 메인화면
                let vc = MainViewController()
                vc.tamagotchi = savedTamagotchi
                if let username = UserDefaults.standard.string(forKey: "username") {
                    vc.user = User(name: username)
                } else {
                    vc.user = User()
                }
                
                let nav = UINavigationController(rootViewController: vc)
                window?.rootViewController = nav
            } else {
                // 선택된 다마고치가 없을 때 -> 선택화면
                let vc = SelectViewController()
                let nav = UINavigationController(rootViewController: vc)
                window?.rootViewController = nav
            }
        } else {
            // 선택된 다마고치가 없을 때 -> 선택화면
            let vc = SelectViewController()
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        }
        
        window?.backgroundColor = .backgroundColor
        window?.tintColor = .fontColor
        window?.makeKeyAndVisible()
    }
}
