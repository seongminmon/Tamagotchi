//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/8/24.
//

import UIKit

struct Setting {
    let imageName: String
    let title: String
    
    var image: UIImage? {
        return UIImage(systemName: imageName)
    }
}

class SettingViewController: UIViewController {
    
    let tableView = UITableView()
    
    var username: String = ""
    
    lazy var list: [Setting] = [
        Setting(imageName: "pencil", title: "내 이름 설정하기"),
        Setting(imageName: "moon.fill", title: "다마고치 변경하기"),
        Setting(imageName: "arrow.clockwise", title: "데이터 초기화")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "설정"
        
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        username = UserDefaults.standard.string(forKey: "username") ?? "유저"
        tableView.reloadData()
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        tableView.backgroundColor = .backgroundColor
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 50
        
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        
        let data = list[indexPath.row]
        cell.configureCell(data)
        if indexPath.row == 0 {
            cell.nameLabel.text = username
        } else {
            cell.nameLabel.text = ""
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // 내 이름 설정하기
            let vc = ChangeNameViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        case 1: // 다마고치 변경하기
            let vc = SelectViewController()
            vc.isSelect = false
            navigationController?.pushViewController(vc, animated: true)
            
        case 2: // 데이터 초기화
            let alert = UIAlertController(
                title: "데이터 초기화",
                message: "정말 다시 처음부터 시작하실 건가용?",
                preferredStyle: .alert
            )
            
            let confirm = UIAlertAction(title: "웅", style: .default) { _ in
                // 데이터 초기화
                let dictionary = UserDefaults.standard.dictionaryRepresentation()
                dictionary.keys.forEach { key in
                    UserDefaults.standard.removeObject(forKey: key)
                }
                // 선택 화면으로 이동
                let vc = SelectViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .crossDissolve
                self.present(nav, animated: true)
            }
            let cancel = UIAlertAction(title: "아냐!", style: .cancel)
            
            alert.addAction(confirm)
            alert.addAction(cancel)
            
            present(alert, animated: true)
        default:
            break
        }
    }
}
