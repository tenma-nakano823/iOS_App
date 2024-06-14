//
//  UserGuideCell.swift
//  enPiT2SUProduct
//
//  Created by 益子　陸 on 2023/01/01.
//

import UIKit

class UserGuideCell: UITableViewCell {

    @IBOutlet weak var guideButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func buttonTapped(_ sender: Any) {
        print("押されました")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
