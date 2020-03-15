//
//  FavoriteColorCollectionViewController.swift
//  RGBController
//
//  Created by Jing Wei Li on 3/14/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreData

class FavoriteColorCollectionViewController: UICollectionViewController {
    let frc = RGBColor.fetchedResultsController
    
    init() {
        try? frc.performFetch()
        super.init(nibName: "FavoriteColorCollectionViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frc.delegate = self
        let length = (UIScreen.main.bounds.width - 20) / 4
        collectionView.collectionViewLayout = FlowLayout(size: CGSize(width: length, height: length), itemSpacing: 5, lineSpacing: 5)
        collectionView?.register(
            UINib(nibName: "FavoritesColorCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: FavoritesColorCollectionViewCell.identifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frc.fetchedObjects?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let color = frc.object(at: indexPath)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesColorCollectionViewCell.identifier, for: indexPath) as? FavoritesColorCollectionViewCell {
            cell.setColor(UIColor(rgbColor: color))
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = frc.object(at: indexPath)
        BLEManager.current.send(
            colorCommand: OutgoingCommands.setColor.rawValue,
            color: UIColor(rgbColor: color))
    }
}

extension FavoriteColorCollectionViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Favorites")
    }
}

extension FavoriteColorCollectionViewController: NSFetchedResultsControllerDelegate {
    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?)
    {
        collectionView.performBatchUpdates({
            collectionView.insertItems(at: [newIndexPath].compactMap { $0 })
        }, completion: nil)
    }
}
