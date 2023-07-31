//
//  RickAndMortyViewController.swift
//  RickAndMorty | no SB | MVVM
//
//  Created by Serhat  Şimşek  on 30.07.2023.
//

import UIKit
import SnapKit

protocol RickAndMortyOutput {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RickAndMortyViewController: UIViewController {
    
    private let labelTitle: UILabel = UILabel()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let tableView: UITableView = UITableView()
    
    private lazy var results: [Result] = []
    
    lazy var viewModel: IRickAndMortyViewModel = RickAndMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
    }

    func configure(){
        makeLabelTitle()
        makeActivityIndicator()
        makeTableView()
        
        drawDesign()
    }
    
    func drawDesign(){
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.async {
            self.view.backgroundColor = .white
            self.labelTitle.textColor = .systemGreen
            self.labelTitle.font = .systemFont(ofSize: 30, weight: .semibold)
            self.labelTitle.text = "Rick And Morty"
            self.tableView.backgroundColor = .purple
            self.activityIndicator.color = .systemPink
        }
        
        self.activityIndicator.startAnimating()
    }
    
    
}

extension RickAndMortyViewController: RickAndMortyOutput {
    func changeLoading(isLoad: Bool) {
        isLoad ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}

extension RickAndMortyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = results[indexPath.row].name ?? ""
        return cell
    }
    
    
}

extension RickAndMortyViewController {
    
    private func makeLabelTitle(){
        view.addSubview(labelTitle)
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(30)
        }
    }
    
    private func makeTableView(){
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(3)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func makeActivityIndicator(){
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.centerY.equalTo(labelTitle)
            make.right.equalTo(labelTitle.snp.right).offset(-12)
        }
    }

    
}
