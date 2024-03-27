//
//  PersonCollectionView.swift
//  VKVirus
//
//  Created by ily.pavlov on 27.03.2024.
//

import UIKit

final class PersonCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
    private func setupCollectionView() {

        register(PersonCell.self, forCellWithReuseIdentifier: PersonCell.cellIdentifier)
    }
}
