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
    
    var data: Tamagotchi?

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
        
        confirmButton.setTitle("시작하기", for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    func configureView() {
        customView.configureView(data)
        descriptionLabel.text = "asdfsadfsadf"
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: false)
    }
    
    @objc func confirmButtonTapped() {
        print(#function)
        let vc = MainViewController()
        vc.data = data
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

}
