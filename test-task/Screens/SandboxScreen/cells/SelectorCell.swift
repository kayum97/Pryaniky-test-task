//
//  SelectorCell.swift
//  test-task
//
//  Created by Admin on 14.02.2021.
//

import UIKit

class SelectorCell: UITableViewCell {
    static let identifierForSelectorCell = "identifierForSelectorCell"
    var pickerView = UIPickerView()
    
    var data: [VariantsModel]? {
        didSet {
            textField.text = data?[0].text
            pickerView.reloadAllComponents()
        }
    }
    
    private var textField = UITextField()
    private var iconSelector = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        iconSelector.image = UIImage(systemName: "chevron.down")
        iconSelector.tintColor = .lightGray
        contentView.addSubview(iconSelector)
        
        contentView.addSubview(textField)
        pickerView.dataSource = self
        pickerView.delegate = self
        textField.inputView = pickerView
        
        iconSelector.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview()
            make.width.height.equalTo(20)
            make.bottom.equalToSuperview().inset(20)
        }
        
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalTo(iconSelector.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension SelectorCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data?[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = data?[row].text
        pickerView.selectRow(row, inComponent: 0, animated: true)
        contentView.endEditing(false)
        pickerView.reloadAllComponents();
    }
}
