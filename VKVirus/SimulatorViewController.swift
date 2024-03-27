//
//  SimulatorViewController.swift
//  VKVirus
//
//  Created by ily.pavlov on 26.03.2024.
//

import UIKit

final class SimulatorViewController: UIViewController {
    
    
    private let personCollectionView = PersonCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var coloredIndexPaths: Set<IndexPath> = []
    private var groupSize = 0
    private var infectionFactor = 0
    private var updatePeriod = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        personCollectionView.register(PersonCell.self, forCellWithReuseIdentifier: "PersonCell")
        personCollectionView.dataSource = self
        personCollectionView.delegate = self
        setupSimulatorUI()
        startPeriodicUpdate()
    }
    
    convenience init(groupSize: Int, infectionFactor: Int, updatePeriod: Int) {
        self.init()
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.updatePeriod = updatePeriod
    }
    
    private func startPeriodicUpdate() {
        let timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(updatePeriod), repeats: true) { [weak self] timer in
            self?.updateCells()
        }
        timer.fire()
    }
    
    private func updateCells() {

        var newlyInfectedIndexPaths: Set<IndexPath> = []
        
        for indexPath in coloredIndexPaths {
            let _ = personCollectionView.cellForItem(at: indexPath) as? PersonCell
            
            let neighborIndexPaths = getNeighborIndexPaths(for: indexPath)
            
            for neighborIndexPath in neighborIndexPaths {
                guard !coloredIndexPaths.contains(neighborIndexPath) else { continue }
                guard newlyInfectedIndexPaths.count < infectionFactor else { break }
                
                newlyInfectedIndexPaths.insert(neighborIndexPath)
            }
        }
        
        coloredIndexPaths.formUnion(newlyInfectedIndexPaths)
        personCollectionView.reloadData()
    }
    
    private func getNeighborIndexPaths(for indexPath: IndexPath) -> [IndexPath] {
        var neighborIndexPaths: [IndexPath] = []

        if indexPath.item > 0 {
            let topNeighborIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            neighborIndexPaths.append(topNeighborIndexPath)
        }

        if indexPath.item < groupSize - 1 {
            let bottomNeighborIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
            neighborIndexPaths.append(bottomNeighborIndexPath)
        }

        if indexPath.section > 0 {
            let leftNeighborIndexPath = IndexPath(item: indexPath.item, section: indexPath.section - 1)
            neighborIndexPaths.append(leftNeighborIndexPath)
        }

        if indexPath.section < groupSize - 1 {
            let rightNeighborIndexPath = IndexPath(item: indexPath.item, section: indexPath.section + 1)
            neighborIndexPaths.append(rightNeighborIndexPath)
        }

        if indexPath.item > 0 && indexPath.section > 0 {
            let diagonalTopLeftNeighborIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section - 1)
            neighborIndexPaths.append(diagonalTopLeftNeighborIndexPath)
        }

        if indexPath.item > 0 && indexPath.section < groupSize - 1 {
            let diagonalTopRightNeighborIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section + 1)
            neighborIndexPaths.append(diagonalTopRightNeighborIndexPath)
        }

        if indexPath.item < groupSize - 1 && indexPath.section > 0 {
            let diagonalBottomLeftNeighborIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section - 1)
            neighborIndexPaths.append(diagonalBottomLeftNeighborIndexPath)
        }

        if indexPath.item < groupSize - 1 && indexPath.section < groupSize - 1 {
            let diagonalBottomRightNeighborIndexPath = IndexPath(item: indexPath.item + 1, section: indexPath.section + 1)
            neighborIndexPaths.append(diagonalBottomRightNeighborIndexPath)
        }

        return neighborIndexPaths
    }

}


extension SimulatorViewController {
    private func setupSimulatorUI() {
        personCollectionView.backgroundColor = .white
        
        view.addSubview(personCollectionView)
        
        personCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            personCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            personCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            personCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SimulatorViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coloredIndexPaths.insert(indexPath)
        collectionView.reloadItems(at: [indexPath])
    }
}

extension SimulatorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.cellIdentifier, for: indexPath) as! PersonCell
        if coloredIndexPaths.contains(indexPath) {
            cell.setCellColor(.systemRed)
        } else {
            cell.setCellColor(.systemGreen)
        }
        return cell
    }
}
