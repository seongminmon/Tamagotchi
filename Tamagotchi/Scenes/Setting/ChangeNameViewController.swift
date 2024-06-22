//
//  ChangeNameViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/8/24.
//

import UIKit
import SnapKit

class ChangeNameViewController: UIViewController {
    
    let userTextField = UITextField()
    let borderView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "\(UserDefaultsManager.user?.name ?? "유저")님 이름 정하기"
        
        let saveButton = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.rightBarButtonItem = saveButton
    }
    
    func configureHierarchy() {
        view.addSubview(userTextField)
        view.addSubview(borderView)
    }
    
    func configureLayout() {
        userTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(userTextField.snp.bottom)
            make.horizontalEdges.equalTo(userTextField)
            make.height.equalTo(1)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        
        userTextField.text = UserDefaultsManager.user?.name ?? "유저"
        userTextField.placeholder = "닉네임을 입력해주세요"
        userTextField.textColor = .fontColor
        userTextField.tintColor = .fontColor
        
        borderView.backgroundColor = .borderColor
    }
    
    @objc func saveButtonTapped() {
        if let name = userTextField.text, name != "" {
            // 유저 이름 저장하기
            UserDefaultsManager.user = User(name: name)
            // 이전 화면으로 돌아가기
            navigationController?.popViewController(animated: true)
        }
    }
}
