//
//  MainTableViewCell.swift
//  test-task
//
//  Created by Admin on 14.02.2021.
//

import UIKit
import SnapKit

class TextCell: UITableViewCell {
    static let identifierForTextCell = "identifierForTextCell"
    var data: TextModel? {
        didSet {
            label.text = data?.text
        }
    }
    
    private var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabel() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
