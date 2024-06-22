//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/8/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let bubbleImageView = UIImageView()
    let bubbleLabel = UILabel()
    let customView = CustomView()
    let descriptionLabel = UILabel()
    
    let riceTextField = UITextField()
    let riceButton = UIButton()
    let waterTextField = UITextField()
    let waterButton = UIButton()
    let separator1 = UIView()
    let separator2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureUI()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "\(UserDefaultsManager.user?.name ?? "유저")님의 다마고치"
        reloadData()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "\(UserDefaultsManager.user?.name ?? "유저")님의 다마고치"
        
        let settingButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(settingButtonTapped)
        )
        navigationItem.rightBarButtonItem = settingButton
        
        // 다음 화면 이동시 현재 화면 타이틀 숨기기
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    @objc func settingButtonTapped() {
        let vc = SettingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureHierarchy() {
        view.addSubview(bubbleImageView)
        view.addSubview(bubbleLabel)
        view.addSubview(customView)
        view.addSubview(descriptionLabel)
        
        view.addSubview(riceTextField)
        view.addSubview(riceButton)
        view.addSubview(waterTextField)
        view.addSubview(waterButton)
        view.addSubview(separator1)
        view.addSubview(separator2)
    }
    
    func configureLayout() {
        bubbleImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(bubbleImageView.snp.width).multipliedBy(0.7)
        }
        
        bubbleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(bubbleImageView).inset(24)
            make.horizontalEdges.equalTo(bubbleImageView).inset(16)
        }
        
        customView.snp.makeConstraints { make in
            make.top.equalTo(bubbleImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(bubbleImageView)
            make.height.equalTo(bubbleImageView.snp.width).multipliedBy(1.2)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(30)
        }
        
        riceTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalTo(bubbleImageView)
            make.trailing.equalTo(riceButton.snp.leading).offset(-4)
            make.height.equalTo(40)
        }
        
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(riceTextField.snp.bottom).offset(8)
            make.leading.equalTo(bubbleImageView)
            make.trailing.equalTo(waterButton.snp.leading).offset(-4)
            make.height.equalTo(40)
        }
        
        riceButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.trailing.equalTo(bubbleImageView)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        waterButton.snp.makeConstraints { make in
            make.top.equalTo(riceButton.snp.bottom).offset(8)
            make.trailing.equalTo(bubbleImageView)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        separator1.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(riceTextField)
            make.height.equalTo(1)
        }
        
        separator2.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(waterTextField)
            make.height.equalTo(1)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        
        bubbleImageView.image = UIImage(named: "bubble")
        bubbleImageView.contentMode = .scaleAspectFill
        
        bubbleLabel.font = .boldSystemFont(ofSize: 15)
        bubbleLabel.textColor = .fontColor
        bubbleLabel.textAlignment = .center
        bubbleLabel.numberOfLines = 0
        
        descriptionLabel.font = .boldSystemFont(ofSize: 15)
        descriptionLabel.textColor = .fontColor
        descriptionLabel.textAlignment = .center
        
        configureTextField(riceTextField, placeholder: "밥주세용")
        configureTextField(waterTextField, placeholder: "물주세용")
        
        riceButton.setTitle("밥먹기", for: .normal)
        riceButton.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        riceButton.addTarget(self, action: #selector(riceButtonTapped), for: .touchUpInside)
        configureButton(riceButton)
        
        waterButton.setTitle("물먹기", for: .normal)
        waterButton.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        waterButton.addTarget(self, action: #selector(waterButtonTapped), for: .touchUpInside)
        configureButton(waterButton)
        
        separator1.backgroundColor = .borderColor
        separator2.backgroundColor = .borderColor
    }
    
    func configureTextField(_ textField: UITextField, placeholder: String) {
        textField.font = .boldSystemFont(ofSize: 15)
        textField.textColor = .fontColor
        textField.textAlignment = .center
        textField.placeholder = placeholder
        textField.keyboardType = .numberPad
    }
    
    func configureButton(_ button: UIButton) {
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.borderColor.cgColor
        button.layer.borderWidth = 1
        
        // 버튼 구성 설정
        var configuration = UIButton.Configuration.plain()
        configuration.titlePadding = 8
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        button.configuration = configuration
    }
    
    func reloadData() {
        var bubbleText = UserDefaultsManager.user?.message.randomElement()
        while bubbleLabel.text == bubbleText {
            bubbleText = UserDefaultsManager.user?.message.randomElement()
        }
        bubbleLabel.text = bubbleText
        customView.configureViewWithMain(UserDefaultsManager.tamagotchi)
        descriptionLabel.text = UserDefaultsManager.tamagotchi?.description
    }
    
    @objc func riceButtonTapped() {
        // 데이터 변경
        let riceString = riceTextField.text ?? ""
        if let riceCnt = Int(riceString) {
            if riceCnt < 100 {
                UserDefaultsManager.tamagotchi?.riceCount += riceCnt
            } else {
                let alert = UIAlertController(
                    title: "100개 이상은 먹을 수 없어요!",
                    message: nil,
                    preferredStyle: .alert
                )
                let confirm = UIAlertAction(title: "확인", style: .default)
                alert.addAction(confirm)
                present(alert, animated: true)
            }
        } else {
            UserDefaultsManager.tamagotchi?.riceCount += 1
        }
        riceTextField.text = ""
        
        // 뷰에 적용
        reloadData()
    }
    
    @objc func waterButtonTapped() {
        // 데이터 변경
        let waterString = waterTextField.text ?? ""
        if let waterCnt = Int(waterString) {
            if waterCnt < 50 {
                UserDefaultsManager.tamagotchi?.waterCount += waterCnt
            } else {
                let alert = UIAlertController(
                    title: "50개 이상은 먹을 수 없어요!",
                    message: nil,
                    preferredStyle: .alert
                )
                let confirm = UIAlertAction(title: "확인", style: .default)
                alert.addAction(confirm)
                present(alert, animated: true)
            }
        } else {
            UserDefaultsManager.tamagotchi?.waterCount += 1
        }
        waterTextField.text = ""
        
        // 뷰에 적용
        reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
