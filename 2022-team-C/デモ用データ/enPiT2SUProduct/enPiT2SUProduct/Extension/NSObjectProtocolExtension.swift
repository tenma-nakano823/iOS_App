//
//  NSObjectProtocolExtension.swift
//  enPiT2SUProduct
//
//  Created by Sion Park on 2022/12/30.
//

import Foundation
import UIKit

// NSObjectProtocolの拡張
extension NSObjectProtocol {

    // クラス名を返す変数"className"を返す
    static var className: String {
        return String(describing: self)
    }
}
