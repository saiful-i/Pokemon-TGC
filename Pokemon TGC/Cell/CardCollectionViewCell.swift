//
//  CardCollectionViewCell.swift
//  Pokemon TGC
//
//  Created by Saiful Islam on 16/02/23.
//

import UIKit
import NetworkModule

class CardCollectionViewCell: UICollectionViewCell {
    lazy var imageView = UIImageView()
    let imageLoader = ImageLoader.shared
    
    var imageUrl: String? {
        didSet {
            bindImage()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraint()
    }
}

extension CardCollectionViewCell {
    private func setupConstraint() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func bindImage() {
        guard let imageUrl = imageUrl else {
            return
        }
        
        imageLoader.attachImage(url: imageUrl, into: imageView)
    }
}
