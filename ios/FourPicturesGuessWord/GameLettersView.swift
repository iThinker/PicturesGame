//
//  GameLettersView.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-17.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameLettersView: UIView {
    
    typealias CollectionViewCell = CollectionViewContainerCell<GameLetterView>
    
    var letters: [GameLevelEntity.Letter]! {
        didSet {
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
        }
    }
    
    var didSelectLetter: ((GameLevelEntity.Letter) -> Void)!
    
    @IBOutlet fileprivate var collectionView: UICollectionView!
    fileprivate var contentSizeObservingContext = 1
    
    deinit {
        self.collectionView.removeObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let reuseIdentifier = CollectionViewCell.defaultReuseIdentifier()
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.addObserver(self, forKeyPath: #keyPath(UICollectionView.contentSize), options: [.new, .old], context: &contentSizeObservingContext)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateCollectionViewLayout()
    }
    
    fileprivate func updateCollectionViewLayout() {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfLettersInLine = CGFloat(self.letters.count / 2)
        let interitemSpace = layout.minimumInteritemSpacing * (numberOfLettersInLine - 1)
        let itemWidth = (self.bounds.width - interitemSpace) / numberOfLettersInLine
        let newItemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.itemSize = newItemSize
        self.collectionView.setNeedsLayout()
        self.collectionView.layoutIfNeeded()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override var intrinsicContentSize: CGSize {
        return self.collectionView.contentSize
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &contentSizeObservingContext {
            if change?[.oldKey] as? CGSize != change?[.newKey] as? CGSize {
                self.invalidateIntrinsicContentSize()
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func letterUpdated(_ letter: GameLevelEntity.Letter) {
        if let index = self.letters.index(where: { $0 === letter }) {
            let indexPath = IndexPath(item: Int(index), section: 0)
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
}

extension GameLettersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.letters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = CollectionViewCell.defaultReuseIdentifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let letter = self.letters[indexPath.item]
        cell.content.letter = letter
        cell.content.onTap = {
            [unowned self] in
            self.didSelectLetter(letter)
        }
        
        return cell
    }
    
}
