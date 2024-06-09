//
//  SelectViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit
import SnapKit

class SelectViewController: UIViewController {
    
    let tableView = UITableView()
    
    var list: [Tamagotchi] = [
        Tamagotchi(number: 1),
        Tamagotchi(number: 2),
        Tamagotchi(number: 3),
        Tamagotchi(number: 0),
    ]
    
    // 선택화면인지 변경화면인지
    var isSelect: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        while list.count < 30 {
            list.append(list.last!)
        }
        
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = isSelect ? "다마고치 선택하기" : "다마고치 변경하기"
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
        switch indexPath.row {
        case 0..<3:
            // 팝업 띄우기
            let vc = PopupViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            let data = list[indexPath.row]
            vc.tamagotchi = data
            vc.isSelect = isSelect
            present(vc, animated: true)
        default:
            break
        }
    }
    
}
