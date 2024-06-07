//
//  SelectViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit

class SelectViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        
    }
    
    func configureUI() {
        navigationItem.title = "다마고치 선택하기"
    }

}

