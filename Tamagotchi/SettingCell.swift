//
//  SettingCell.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/8/24.
//

import UIKit
import SnapKit

class SettingCell: UITableViewCell {
    
    let settingImageView = UIImageView()
    let titleLabel = UILabel()
    let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        contentView.addSubview(settingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(nameLabel)
        
        settingImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(settingImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.trailing.equalTo(nameLabel.snp.leading).offset(-8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.font = .systemFont(ofSize: 13)
        nameLabel.textAlignment = .right
    }
    
    func configureCell(_ data: Setting) {
        settingImageView.image = data.image
        titleLabel.text = data.title
    }
}
