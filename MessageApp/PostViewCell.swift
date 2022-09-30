//
//  PostViewCell.swift
//  MessageApp
//
//  Created by Juan Camilo Mendieta Hernández on 27/09/22.
//

import Foundation
import UIKit

protocol PostViewCellDelegate: UIViewController {
    func addOrRemoveFavorite(in cell: PostViewCell)
}

class PostViewCell: UITableViewCell {
    weak var delegate: PostViewCellDelegate?
    var isFavorite = false
    let starButton = UIButton(type: .system)
    let emptyStar = UIImage(systemName: "star")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
    let filledStar = UIImage(systemName: "star.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)

    static let identifier = "PostViewCell"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        starButton.setImage(emptyStar, for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        starButton.addTarget(self, action: #selector(markAsFavorite), for: .touchUpInside)
        accessoryView = starButton
    }
    
    override func prepareForReuse() {
        // TODO: fill the star when tapped
    }
    
    @objc private func markAsFavorite() {
        
        // TODO: fill the star when tapped
        
//        isFavorite = !isFavorite
//        if isFavorite {
//            starButton.setImage(filledStar, for: .normal)
//        } else {
//            starButton.setImage(emptyStar, for: .normal)
//        }
        
        delegate?.addOrRemoveFavorite(in: self)
    }
}
