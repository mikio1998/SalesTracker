//
//  ProductIndexView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/18.
//
// https://qiita.com/uhooi/items/ce1b8f56fe7d3eaca325

import Foundation
import UIKit

protocol ProductIndexViewLike: ViewContainer {
//    Keep reference to the presenter that initializes this view.
    var presenterLike: ProductIndexPresenterLike? { get set }
    func setTitleAndImage(_ title: String, imageUrl: String)
    func setSnapshot(_ snapshot: ProductIndexSnapshot)
    func noResults(error: FirestoreError?)
}

final class ProductIndexView: XibView {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, ProductIndexCollectionSnapshotDataModel>
    private lazy var dataSource: DataSource = {
        .init(collectionView: collectionView, cellProvider: cellProvider)
    }()
    
    private lazy var cellProvider: DataSource.CellProvider = { collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductIndexCollectionViewCell", for: indexPath) as! ProductIndexCollectionViewCell
        cell.setUpCell(model: item)
        return cell
    }
    weak var presenterLike: ProductIndexPresenterLike?
    @IBOutlet weak var listButton: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.register(UINib(nibName: "ProductIndexCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductIndexCollectionViewCell")
        }
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dropdownLabel: UILabel!
    
    @IBOutlet weak var noResultsView: UIView!
    
    @IBOutlet weak var noResultLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        self.dropdownLabel.text = "変更"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.listButton.addGestureRecognizer(tapGesture)
        self.listButton.giveRoundCorners(withCornerRadius: 20)
    }
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapGestureRecognizerAction(sender: UITapGestureRecognizer) {
        presenterLike?.didTapListButton()        
    }
    

}

extension ProductIndexView: ProductIndexViewLike {
    func setTitleAndImage(_ title: String, imageUrl: String) {
        self.titleLabel.text = title
        self.logoImageView.loadImage(with: imageUrl)
    }
    
    func setSnapshot(_ snapshot: ProductIndexSnapshot) {
        if snapshot.itemIdentifiers.isEmpty {
            noResults(error: nil)
        }
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func noResults(error: FirestoreError?) {
        print("No results found.")
        collectionView.alpha = 0
        noResultsView.alpha = 1
        noResultLabel.alpha = 1
        noResultLabel.text = error != nil ? error?.message : "検索結果がありません。"
    }
}

extension ProductIndexView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width * 5 / 18 + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenterLike?.didSelectIndexPath(indexPath)
    }
}

// Notes:
// Diffable data source
//      typealias of datasource
//      init the datasource
//      cell provider


// IBOutlet tableview
//      when set,
//          set delegate to self. register cells.
//          tableView.tableFooterView = UIView()
//
// Other view IBOutlets if necessary


// init() and required init
