//
//  PictureCell.swift
//  test-task
//
//  Created by Admin on 14.02.2021.
//

import UIKit
import Kingfisher

class PictureCell: UITableViewCell {
    static let identifierForPictureCell = "identifierForPictureCell"
    var data: PictureModel? {
        didSet {
            title.text = data?.text
            let url = URL(string: data?.url ?? "")
            photo.kf.setImage(with: url, options: [.cacheOriginalImage])
        }
    }
    
    private var title = UILabel()
    private var photo = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(title)
        contentView.addSubview(photo)
        
        photo.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(60)
            make.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalTo(photo.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
