//
//  TamagotchiCell.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit
import SnapKit

class TamagotchiCell: UITableViewCell {
    
    let customView = CustomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
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
