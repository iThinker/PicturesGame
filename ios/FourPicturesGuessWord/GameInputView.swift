//
//  GameInputView.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2016-12-17.
//  Copyright © 2016 Temkos. All rights reserved.
//

import UIKit

class GameInputView: UIView {
    
    typealias CollectionViewCell = CollectionViewContainerCell<GameInputLetterView>
    
    var input: [GameLevelEntity.InputLetter]! {
        didSet {
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }, completion: nil)
        }
    }
    
    var didSelectLetter: ((GameLevelEntity.InputLetter) -> Void)!
    
    @IBOutlet fileprivate var collectionView: UICollectionView!
    @IBOutlet fileprivate var collectionViewWidthLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var collectionViewHeightLayoutConstraint: NSLayoutConstraint!
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
        let numberOfLettersInLine = CGFloat(GameLevelEntity.MaxInputLength)
        let interitemSpace = layout.minimumInteritemSpacing * (numberOfLettersInLine - 1)
        let itemWidth = (self.bounds.width - interitemSpace) / numberOfLettersInLine
        let newItemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.itemSize = newItemSize
        self.collectionViewHeightLayoutConstraint.constant = itemWidth
    }
    
    override var intrinsicContentSize: CGSize {
        return self.collectionView.collectionViewLayout.collectionViewContentSize
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &contentSizeObservingContext {
            if change?[.oldKey] as? CGSize != change?[.newKey] as? CGSize {
                self.invalidateIntrinsicContentSize()
                self.collectionViewWidthLayoutConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.width
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    func inputUpdated(_ letter: GameLevelEntity.InputLetter) {
        if let index = self.input.index(where: { $0 === letter }) {
            let indexPath = IndexPath(item: Int(index), section: 0)
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
}

extension GameInputView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.input?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = CollectionViewCell.defaultReuseIdentifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let letter = self.input[indexPath.item]
        cell.content.inputLetter = letter
        cell.content.onTap = {
            [unowned self] in
            self.didSelectLetter(letter)
        }
        
        return cell
    }
    
}
