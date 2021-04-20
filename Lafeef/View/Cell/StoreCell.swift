//
//  StoreCell.swift
//  Lafeef
//
//  Created by Renad nasser on 30/03/2021.
//

import UIKit
internal final class StoreCell: UITableViewCell {

    
    @IBOutlet weak var equipmentImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func layoutSubviews() {
         super.layoutSubviews()
         let bottomSpace: CGFloat = 20.0
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
        
        self.selectionStyle = .none
        self.contentView.layer.cornerRadius = 40
        self.contentView.layer.masksToBounds = true

        self.contentView.layer.masksToBounds = false
        self.contentView.layer.shadowOffset = CGSize(width: 0.25, height: 0.25)
        self.contentView.layer.shadowColor = UIColor.black.cgColor
        self.contentView.layer.shadowOpacity = 0.23
        self.contentView.layer.shadowRadius = 4

        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        //Style Cell
        ///Round Corner
        equipmentImage.image = nil
        label.text = nil
        

    }

}
