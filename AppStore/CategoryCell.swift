//
//  CategoryCell.swift
//  AppStore
//
//  Created by SANGBONG MOON on 29/01/2019.
//  Copyright © 2019 Scott Moon. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var appCategory: AppCategory? {
        didSet {

            if let name = appCategory?.name {
                nameLabel.text = name
            }
        }
    }

    private let cellId = "appCellId"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let appsCollectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    func setupViews() {
        backgroundColor = .clear

        addSubview(appsCollectionView)
        addSubview(dividerLineView)
        addSubview(nameLabel)

        appsCollectionView.dataSource = self
        appsCollectionView.delegate = self

        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)

        let nameHorizonLayout = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-14-[v0]|",
            options: [],
            metrics: nil,
            views: ["v0": nameLabel]
        )

        addConstraints(nameHorizonLayout)

        let dividerHorizonLayout = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-14-[v0]|",
            options: [],
            metrics: nil,
            views: ["v0": dividerLineView]
        )

        addConstraints(dividerHorizonLayout)

        let ContentHorizonLayout = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[v0]|",
            options: [],
            metrics: nil,
            views: ["v0": appsCollectionView]
        )

        addConstraints(ContentHorizonLayout)

        let ContentVerticalLayout = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[nameLabel(30)][v0][v1(0.5)]|",
            options: [],
            metrics: nil,
            views: ["v0": appsCollectionView, "v1": dividerLineView, "nameLabel": nameLabel]
        )

        addConstraints(ContentVerticalLayout)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appCategory?.apps?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 32)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }

}

class AppCell: UICollectionViewCell {

    var app: App? {
        didSet {
            if let name = app?.name {
                nameLable.text = name

                let rect = NSString(string: name).boundingRect(
                    with: CGSize(width: frame.width, height: 1000),
                    options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin),
                    attributes: [.font: UIFont.systemFont(ofSize: 14)],
                    context: nil
                )

                if rect.height > 20 {
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
                } else {
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 22, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width + 40, width: frame.width, height: 20)
                }

                nameLable.frame = CGRect(x: 0, y: frame.width + 5, width: frame.width, height: 40)
                nameLable.sizeToFit()
            }

            categoryLabel.text = app?.category

            if let price = app?.price {
                priceLabel.text = "$\(price)"
            } else {
                priceLabel.text = ""
            }

            if let imageName = app?.imageName {
                imageView.image = UIImage(named: imageName)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()

    let nameLable: UILabel = {
        let label = UILabel()
        label.text = "Disney Build It: Frozen"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Enterainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()

    func setupViews() {
        addSubview(imageView)
        addSubview(nameLable)
        addSubview(categoryLabel)
        addSubview(priceLabel)

        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLable.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
    }
}
