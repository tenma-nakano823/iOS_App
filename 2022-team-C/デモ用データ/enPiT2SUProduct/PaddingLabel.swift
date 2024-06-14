//
//  PaddingLabel.swift
//  enPiT2SUProduct
//
//  Created by 益子　陸 on 2023/01/01.
//

import UIKit

final class PaddingLabel: UILabel {
    var padding: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += padding.left + padding.right
        size.height += padding.top + padding.bottom
        return size
    }
}
