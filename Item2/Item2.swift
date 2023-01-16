//
//  Item2.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 29/7/2022.
//

import UIKit

class Item2: UIViewController {
    
    let manager = GalleryManager()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Category2, Gallery>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "純影集"
        manager.fetch() {(items) in manager.galleries = items}
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(Item2Cell.self, forCellWithReuseIdentifier: Item2Cell.cellID)
        collectionView.backgroundView = UIImageView(image: UIImage(named: "grass"))
        collectionView.delegate = self
        view.addSubview(collectionView)
        createDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = sender as? IndexPath else {return}
        if segue.identifier == Item2CellDetails.segueID {
            if let vc = segue.destination as? Item2CellDetails {
                vc.selectedItem = dataSource.itemIdentifier(for: index)
            }
        }
    }
    
}

extension Item2 {
    func firstLayout() -> NSCollectionLayoutSection {
        
        let inset = CGFloat(5)
        
        let item1Size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2 / 3), heightDimension: .fractionalHeight(1))
        let item1 = NSCollectionLayoutItem(layoutSize: item1Size)
        item1.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let verticalStackItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 2))
        let verticalStackItem = NSCollectionLayoutItem(layoutSize: verticalStackItemSize)
        verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let horizontalStackItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1))
        let horizontalStackItem = NSCollectionLayoutItem(layoutSize: horizontalStackItemSize)
        horizontalStackItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        //let group1Size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 6))
        //let group1 = NSCollectionLayoutGroup.horizontal(layoutSize: group1Size, subitems: [item1])
        
        let verticalStackGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)),
            subitem: verticalStackItem,
            count: 2
        )
        
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/6)),
            subitems: [horizontalStackItem, horizontalStackItem, horizontalStackItem]
        )
        
        let horizontalLeftGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)),
            subitems: [item1, verticalStackGroup]
        )
        
        let horizontalRightGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1/3)),
            subitems: [verticalStackGroup, item1]
        )
        
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1)),
            subitems: [horizontalLeftGroup, horizontalGroup, horizontalRightGroup, horizontalGroup]
        )

        let section = NSCollectionLayoutSection(group: verticalGroup)
        
        return section
    }
    
    func secondLayout() -> NSCollectionLayoutSection {
        
        var itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1))
        if UIDevice.current.userInterfaceIdiom ==  .pad {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 4), heightDimension: .fractionalHeight(1))
        }
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 12))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func thirdLayout() -> NSCollectionLayoutSection {
        var itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 3), heightDimension: .fractionalHeight(1))
        if UIDevice.current.userInterfaceIdiom ==  .pad {
            itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 4), heightDimension: .fractionalHeight(1))
        }
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1 / 12))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {[unowned self] (sectionIndex, environment) in
            if sectionIndex > 4 {
                return secondLayout()
            } else {
                return thirdLayout()
            }
        }
    }
}

extension Item2 {
    func createDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<Item2Cell, Gallery> {
            (cell, indexPath, identifier) in
            DispatchQueue.main.async {
            cell.imageView.image = UIImage(named: identifier.image)
            }
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell> (elementKind: UICollectionView.elementKindSectionHeader) {
            (header, elementKind, indexPath) in
            var configuration = header.defaultContentConfiguration()
            switch (indexPath.section) {
            case 0: configuration.text = "萬宜東覇"
            case 1: configuration.text = "大潭水塘"
            case 2: configuration.text = "城門水塘"
            case 3: configuration.text = "流水響"
            case 4: configuration.text = "鶴咀"
            default: configuration.text = "其他"
            }
            configuration.textProperties.alignment = .center
            configuration.textProperties.color = .systemRed
            configuration.textProperties.font = .boldSystemFont(ofSize: 20)
            header.contentConfiguration = configuration
            
        }
        
        dataSource = UICollectionViewDiffableDataSource<Category2, Gallery> (collectionView: collectionView){
            (collectionView, indexPath, identifier) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        dataSource.supplementaryViewProvider = {
            (collectionView, elementKind, indexPath) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Category2, Gallery> ()
        for category in Category2.allCases {
            let items = manager.galleries.filter {$0.category == category}
            snapshot.appendSections([category])
            snapshot.appendItems(items)
        }
        DispatchQueue.main.async {
        self.dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    }
}

extension Item2: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Item2CellDetails.segueID, sender: indexPath)
    }
}
