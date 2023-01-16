//
//  Item1.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 29/7/2022.
//

import UIKit

class Item1: UIViewController {
    
    let manager = HikingManager()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Category, Hiking>!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "戶外遠足行山資訊App"
        manager.fetch()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(Item1Cell.self, forCellWithReuseIdentifier: Item1Cell.cellID)
        collectionView.delegate = self
        collectionView.backgroundView = UIImageView(image: UIImage(named: "grass"))
        view.backgroundColor = .systemGreen
        view.addSubview(collectionView)
        createDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = sender as? IndexPath else {return}
        if segue.identifier == Item1CellDetails.segueID {
            if let vc = segue.destination as? Item1CellDetails {
                vc.selectedItem = dataSource.itemIdentifier(for: index)
            }
        }
    }
}

extension Item1 {
    func createDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<Item1Cell, Hiking> {
            (cell, indexPath, identifier) in
            cell.imageView.image = UIImage(named: identifier.image)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell> (elementKind: UICollectionView.elementKindSectionHeader) {
            (header, elementKind, indexPath) in
            var configuration = header.defaultContentConfiguration()
            switch (indexPath.section) {
            case 0: configuration.image = UIImage(named: "title-1")
            case 1: configuration.image = UIImage(named: "title-2")
            case 2: configuration.image = UIImage(named: "title-3")
            default: configuration.image = UIImage(named: "title-4")
            }
            //configuration.image = UIImage(named: "title-1")
            header.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource<Category, Hiking> (collectionView: collectionView){
            (collectionView, indexPath, identifier) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        dataSource.supplementaryViewProvider = {
            (collectionView, elementKind, indexPath) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Category, Hiking> ()
        for category in Category.allCases {
            let items = manager.hikings.filter {$0.category == category}
            snapshot.appendSections([category])
            snapshot.appendItems(items)
        }
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
}

extension Item1 {
    func firstLayout() -> NSCollectionLayoutSection {
        
        var itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .fractionalHeight(1))
        if UIDevice.current.userInterfaceIdiom ==  .pad {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1))
        }
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 12))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {[unowned self] (sectionIndex, environment) in
            return firstLayout()
        }
    }
}

extension Item1: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Item1CellDetails.segueID, sender: indexPath)
    }
}
