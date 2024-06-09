//
//  PopupViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit
import SnapKit

class PopupViewController: UIViewController {
    
    let popupView = UIView()
    
    let customView = CustomView()
    let separator = UIView()
    let descriptionLabel = UILabel()
    let cancelButton = UIButton()
    let confirmButton = UIButton()
    
    var isSelect: Bool = true
    var tamagotchi: Tamagotchi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureView()
    }
    
    func configureHierarchy() {
        popupView.addSubview(customView)
        popupView.addSubview(separator)
        popupView.addSubview(descriptionLabel)
        popupView.addSubview(cancelButton)
        popupView.addSubview(confirmButton)
        view.addSubview(popupView)
    }
    
    func configureLayout() {
        popupView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        customView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(180)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(cancelButton.snp.top).offset(-16)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(popupView.snp.width).multipliedBy(0.5)
            make.height.equalTo(40)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.equalTo(cancelButton.snp.trailing)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        
        popupView.backgroundColor = .backgroundColor
        popupView.clipsToBounds = true
        popupView.layer.cornerRadius = 20
        
        separator.backgroundColor = .borderColor
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .fontColor
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.backgroundColor = .systemGray5
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        confirmButton.setTitle(isSelect ? "시작하기" : "변경하기", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    func configureView() {
        guard let tamagotchi else { return }
        customView.configureViewWithSelection(tamagotchi)
        descriptionLabel.text = tamagotchi.description
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func confirmButtonTapped() {
        guard let tamagotchi else { return }
        
        let vc = MainViewController()
        if isSelect {
            // 선택하기면 새로 만들기
            vc.tamagotchi = tamagotchi
        } else {
            if let savedData = UserDefaults.standard.object(forKey: "tamagotchi") as? Data {
                if var savedTamagotchi = try? JSONDecoder().decode(Tamagotchi.self, from: savedData) {
                    savedTamagotchi.number = tamagotchi.number
                    vc.tamagotchi = savedTamagotchi
                }
            }
            if let username = UserDefaults.standard.string(forKey: "username") {
                vc.user = User(name: username)
            } else {
                vc.user = User()
            }
        }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true)
    }
    
}
