//
//  SandboxViewController.swift
//  test-task
//
//  Created by Admin on 14.02.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SandboxViewController: UIViewController {
    
    var sandboxViewModel: SandboxViewModelProtocol!
    private let disposeBag = DisposeBag()
    
    private let tableView = UITableView()
    private var dictionary: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        bindViewModel()
        bindUi()
        self.sandboxViewModel?.loadData()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        configureTableView()
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    private func createTextBlockCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextCell.identifierForTextCell, for: indexPath) as! TextCell
        cell.data = self.dictionary["hz"] as? TextModel
        return cell
    }
    
    private func createPictureBlockCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifierForPictureCell, for: indexPath) as! PictureCell
        cell.data = self.dictionary["picture"] as? PictureModel
        return cell
    }
    
    private func createSelectorBlockCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.identifierForSelectorCell, for: indexPath) as! SelectorCell
        guard let data = self.dictionary["selector"] as? SelectorModel else { return UITableViewCell() }
        cell.data = data.variants
        cell.pickerView.rx.itemSelected.bind{ [weak self] data in
            guard let self = self, let selectorData = self.dictionary["selector"] as? SelectorModel else { return }
            self.showSimpleAlert(title: "", message: "id \(data.row + 1)\n\(selectorData.variants[data.row].text)")
        }.disposed(by: disposeBag)
        return cell
    }
    
    private func bindViewModel() {
        self.sandboxViewModel.dictionaryRelay.bind{ [weak self] data in
            guard let self = self else { return }
            self.dictionary = data
        }.disposed(by: disposeBag)
        
        self.sandboxViewModel.viewsRelay.bind(to: tableView.rx.items) {[weak self] (tableView, row, element) -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            
            let indexPath = IndexPath(row: row, section: 0)
            switch element {
            case .hz:
                return self.createTextBlockCell(indexPath: indexPath)
            case .picture:
                return self.createPictureBlockCell(indexPath: indexPath)
            case .selector:
                return self.createSelectorBlockCell(indexPath: indexPath)
            }
        }.disposed(by: disposeBag)
        
        self.sandboxViewModel.errorSubject.map { error -> String? in
            switch error {
            case is AppError:
                return (error as? AppError)?.rawValue
            default:
                return nil
            }
        }
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self]  error in
            guard let self = self else { return }
            self.showSimpleAlert(title: "Error", message: error)
        })
        .disposed(by: disposeBag)
    }
    
    private func bindUi() {
        tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                let cell = self.tableView.cellForRow(at: indexPath)
                self.tableView.deselectRow(at: indexPath, animated: true)
                switch cell {
                case is TextCell:
                    guard let cell = cell as? TextCell,
                          let data = cell.data else { return }
                    self.showSimpleAlert(title: "", message: "\(data.text)")
                case is PictureCell:
                    guard let cell = cell as? PictureCell,
                          let data = cell.data else { return }
                    self.showSimpleAlert(title: "", message: "\(data.text)")
                case is SelectorCell:
                    break
                default:
                    self.showSimpleAlert(title: "Error", message: "Unknown UI element")
                }
            }.disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(TextCell.self, forCellReuseIdentifier: TextCell.identifierForTextCell)
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifierForPictureCell)
        tableView.register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.identifierForSelectorCell)
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = 60.0
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

