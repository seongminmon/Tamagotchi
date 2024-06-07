//
//  TamagotchiCell.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/7/24.
//

import UIKit
import SnapKit

class TamagotchiCell: UITableViewCell {
    
    let mainImageView = UIImageView()
    let labelContainerView = UIView()
    let nameLabel = UILabel()
    
    static let identifier = "TamagotchiCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .backgroundColor
        
        contentView.addSubview(mainImageView)
        labelContainerView.addSubview(nameLabel)
        contentView.addSubview(labelContainerView)
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalTo(labelContainerView.snp.top).offset(-4)
            make.centerX.equalToSuperview()
            make.width.equalTo(mainImageView.snp.height)
        }
        
        labelContainerView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
        
        labelContainerView.clipsToBounds = true
        labelContainerView.layer.cornerRadius = 10
        labelContainerView.layer.borderColor = UIColor.borderColor.cgColor
        labelContainerView.layer.borderWidth = 1
        
        nameLabel.font = .systemFont(ofSize: 13)
        nameLabel.textColor = .fontColor
        nameLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ data: Tamagotchi) {
        mainImageView.image = data.image
        nameLabel.text = data.name
    }
}
