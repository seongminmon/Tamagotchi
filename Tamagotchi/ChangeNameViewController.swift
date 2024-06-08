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

        navigationItem.title = "유저님 이름 정하기"
        
        let saveButton = UIBarButtonItem(
            title: "저장",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.rightBarButtonItem = saveButton
        
        view.addSubview(userTextField)
        view.addSubview(borderView)
        
        userTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        borderView.snp.makeConstraints { make in
            make.top.equalTo(userTextField.snp.bottom)
            make.horizontalEdges.equalTo(userTextField)
            make.height.equalTo(1)
        }
        
        view.backgroundColor = .backgroundColor
        
        userTextField.text = "유저"
        userTextField.placeholder = "이름을 입력해주세요"
        userTextField.textColor = .fontColor
        userTextField.tintColor = .fontColor
        
        borderView.backgroundColor = .borderColor
    }
    
    @objc func saveButtonTapped() {
        print(#function)
        // TODO: - 유저 이름 저장하기
    }
}
