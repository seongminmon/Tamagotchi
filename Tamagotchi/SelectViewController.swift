//
//  SelectViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit
import SnapKit

struct Tamagotchi {
    let name: String
    let imageName: String
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
}

class SelectViewController: UIViewController {
    
    let tableView = UITableView()
    
    var list: [Tamagotchi] = [
        Tamagotchi(name: "따끔따끔 다마고치", imageName: "1-6"),
        Tamagotchi(name: "방실방실 다마고치", imageName: "2-6"),
        Tamagotchi(name: "반짝반짝 다마고치", imageName: "3-6"),
        Tamagotchi(name: "준비중이에요", imageName: "noImage"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        while list.count < 30 {
            list.append(list.last!)
        }
        
        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    
    func configureNavigation() {
        navigationItem.title = "다마고치 선택하기"
//        navigationItem.title = "다마고치 변경하기"
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 180
        tableView.backgroundColor = .backgroundColor
        
        tableView.register(TamagotchiCell.self, forCellReuseIdentifier: TamagotchiCell.identifier)
    }

}

extension SelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TamagotchiCell.identifier, for: indexPath) as! TamagotchiCell
        
        let data = list[indexPath.row]
        cell.configureCell(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PopupViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
    }
}
