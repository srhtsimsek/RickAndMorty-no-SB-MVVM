//
//  RickAndMortyTableViewCell.swift
//  RickAndMorty | no SB | MVVM
//
//  Created by Serhat  Şimşek  on 31.07.2023.
//

import UIKit
import AlamofireImage

final class RickAndMortyTableViewCell: UITableViewCell {

    private let customImageViewOfCell: UIImageView = UIImageView()
    private let titleOfCell: UILabel = UILabel()
    private let descriptionOfTitle: UILabel = UILabel()
    
    private lazy var randomImage: String = "https://picsum.photos/200/300"
    
    enum Identifier: String {
        case custom = "rickAndMortyTableViewCellid"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellitems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCellitems() {
        makeCustomImageView()
        makeTitleOfCell()
        makeDescriptionOfTitle()
    }
    
    private func makeCustomImageView() {
        addSubview(customImageViewOfCell)
        
        customImageViewOfCell.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.top.equalTo(contentView)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func makeTitleOfCell() {
        addSubview(titleOfCell)
        titleOfCell.font = .systemFont(ofSize: 18, weight: .semibold)
        
        titleOfCell.snp.makeConstraints { make in
            make.top.equalTo(customImageViewOfCell.snp.bottom).offset(5)
            make.right.left.equalTo(contentView).offset(3)
        }
    }
    
    private func makeDescriptionOfTitle() {
        addSubview(descriptionOfTitle)
        descriptionOfTitle.font = .italicSystemFont(ofSize: 12)
        
        descriptionOfTitle.snp.makeConstraints { make in
            make.top.equalTo(titleOfCell).offset(10)
            make.right.left.equalTo(titleOfCell).offset(3)
            make.bottom.equalToSuperview()
        }
    }
    
    func saveModel(model: Result) {
        titleOfCell.text = model.name
        descriptionOfTitle.text = model.status
        customImageViewOfCell.af.setImage(withURL: (URL(string: model.image ?? randomImage) ?? URL(string: randomImage))!)
    }
}
