//
//  TamagotchiCell.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit
import SnapKit

class TamagotchiCell: UICollectionViewCell {
    
    let customView = CustomView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.backgroundColor = .backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: Tamagotchi) {
        customView.configureViewWithSelection(data)
    }
}
