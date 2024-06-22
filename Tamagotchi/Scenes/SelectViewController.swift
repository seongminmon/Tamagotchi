//
//  SelectViewController.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit
import SnapKit

class SelectViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var list: [Tamagotchi] = [
        Tamagotchi(number: 1),
        Tamagotchi(number: 2),
        Tamagotchi(number: 3),
        Tamagotchi(number: 0),
    ]
    
    // 선택 화면인지 변경 화면인지
    var isSelect: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        while list.count < 30 {
            list.append(list.last!)
        }
        
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureCollectionView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = isSelect ? "다마고치 선택하기" : "다마고치 변경하기"
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 40)
        layout.itemSize = CGSize(width: width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = .backgroundColor
        
        collectionView.register(SelectCollectionViewCell.self, forCellWithReuseIdentifier: SelectCollectionViewCell.identifier)
    }
}

extension SelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCollectionViewCell.identifier, for: indexPath) as! SelectCollectionViewCell
        
        let data = list[indexPath.item]
        cell.configureCell(data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0..<3:
            // 팝업 띄우기
            let vc = PopupViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            let data = list[indexPath.item]
            vc.tamagotchi = data
            vc.isSelect = isSelect
            present(vc, animated: true)
        default:
            break
        }
    }
}
