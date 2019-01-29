//
//  ViewController.swift
//  AppStore
//
//  Created by SANGBONG MOON on 29/01/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class FeatruedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellId = "cellId"

    var appCategories: [AppCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()

//        appCategories = AppCategory.sampleAppCategories()

        AppCategory.fetchFeaturedApps { appCategories in
            self.appCategories = appCategories
            self.collectionView?.reloadData()
        }

        collectionView?.backgroundColor = .white

        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell

        cell.appCategory = appCategories?[indexPath.row]
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appCategories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }

}
