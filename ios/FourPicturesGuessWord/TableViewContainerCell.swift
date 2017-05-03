//
//  TableViewContainerCell.swift
//  FourPicturesGuessWord
//
//  Created by Roman Temchenko on 2017-04-30.
//  Copyright © 2017 Temkos. All rights reserved.
//

import UIKit

class TableViewContainerCell<Content: UIView>: UITableViewCell {
    
    var content: Content
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        if let viewFromNib = Content.loadDefaultNib() {
            content = viewFromNib
        }
        else {
            content = Content(frame: .zero)
        }
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.embedContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func embedContent() {
        let containerView = self.contentView
        containerView.addSubview(self.content)
        self.content.translatesAutoresizingMaskIntoConstraints = false
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: [], metrics: nil, views: ["view": self.content]))
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]->=0-|", options: [], metrics: nil, views: ["view": self.content]))
    }

}
