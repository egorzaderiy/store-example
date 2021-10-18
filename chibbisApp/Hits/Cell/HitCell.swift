//
//  HitCell.swift
//  chibbisApp
//
//  Created by Egor Zaderiy on 16.10.2021.
//

import UIKit

class HitCell: UITableViewCell {
    
    weak var mainImageView: UIImageView!
    weak var nameLabel: UILabel!
    weak var frameView: UIView!
    weak var tapGest: UILongPressGestureRecognizer!

    var showDetail: ((_ image: UIImage) -> Void)?
    var hideDetail: (() -> Void)?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        gestureRecognizers?.forEach { contentView.removeGestureRecognizer($0) }
        let frameView = UIView()
        frameView.translatesAutoresizingMaskIntoConstraints = false
        self.frameView = frameView
        contentView.addSubview(frameView)
        frameView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        frameView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        frameView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        frameView.widthAnchor.constraint(equalTo: frameView.heightAnchor).isActive = true
        
        frameView.layer.borderWidth = 2
        frameView.layer.borderColor = UIColor.gray.cgColor
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView = imageView
        frameView.addSubview(mainImageView)
        mainImageView.centerXAnchor.constraint(equalTo: frameView.centerXAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 20).isActive = true
        mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor).isActive = true
        mainImageView.leftAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: frameView.leftAnchor, multiplier: 1).isActive = true
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        nameLabel = label
        frameView.addSubview(nameLabel)
        
        mainImageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -20).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: frameView.centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: -10).isActive = true
        nameLabel.leftAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: frameView.leftAnchor, multiplier: 1).isActive = true
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(gestureAction(_:)))
        tapGesture.minimumPressDuration = 0.5
        tapGest = tapGesture
        mainImageView.isUserInteractionEnabled = true
        mainImageView.addGestureRecognizer(tapGest)
    }
    

    @objc func gestureAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            if let img = mainImageView?.image {
                showDetail?(img)
            }
        case .ended:
            hideDetail?()
        default:
            break
        }
    }

}
