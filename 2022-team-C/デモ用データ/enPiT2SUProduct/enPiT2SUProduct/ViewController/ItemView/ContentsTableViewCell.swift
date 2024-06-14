//
//  ContentsTableViewCell.swift
//  enPiT2SUProduct
//
//  Created by Sion Park on 2023/01/02.
//

import UIKit

protocol CustomCellDelegate {
    func customCellDelegateDidTapButton(cell: UITableViewCell)
}

class ContentsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var delegate: CustomCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.customCellDelegateDidTapButton(cell: self)
    }
}
