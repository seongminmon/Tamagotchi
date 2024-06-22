//
//  CustomView.swift
//  Tamagotchi
//
//  Created by 김성민 on 6/8/24.
//

import UIKit
import SnapKit

class CustomView: UIView {
    
    let mainImageView = UIImageView()
    let labelContainerView = UIView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLayout() {
        labelContainerView.addSubview(nameLabel)
        addSubview(mainImageView)
        addSubview(labelContainerView)
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalTo(labelContainerView.snp.top).offset(-8)
            make.centerX.equalToSuperview()
            make.width.equalTo(mainImageView.snp.height)
        }
        
        labelContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.bottom.equalToSuperview().inset(8)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        labelContainerView.clipsToBounds = true
        labelContainerView.layer.cornerRadius = 10
        labelContainerView.layer.borderColor = UIColor.borderColor.cgColor
        labelContainerView.layer.borderWidth = 1
        
        nameLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.textColor = .fontColor
        nameLabel.textAlignment = .center
    }
    
    func configureViewWithMain(_ data: Tamagotchi?) {
        mainImageView.image = data?.image
        nameLabel.text = data?.name
    }
    
    func configureViewWithSelection(_ data: Tamagotchi?) {
        mainImageView.image = data?.firstImage
        nameLabel.text = data?.name
    }
}
