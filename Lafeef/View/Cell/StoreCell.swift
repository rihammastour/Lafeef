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
    
    @IBOutlet weak var button: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        equipmentImage.image = nil
        label.text = nil

    }

}
