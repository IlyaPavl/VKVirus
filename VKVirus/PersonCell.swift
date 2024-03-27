//
//  PersonCell.swift
//  VKVirus
//
//  Created by ily.pavlov on 27.03.2024.
//

import UIKit

final class PersonCell: UICollectionViewCell {
    
    static let cellIdentifier = "PersonCell"
    var isInfected: Bool = false
    
    private let personImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGreen
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(personImageView)
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            personImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImageView.widthAnchor.constraint(equalTo: widthAnchor),
            personImageView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    func setCellColor(_ color: UIColor) {
        personImageView.tintColor = color
    }
}
