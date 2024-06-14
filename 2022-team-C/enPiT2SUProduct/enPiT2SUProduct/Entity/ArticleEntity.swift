//
//  ArticleEntity.swift
//  enPiT2SUProduct
//
//  Created by Sion Park on 2022/12/30.
//

import UIKit
import Foundation

class ArticleEntity {
    
    // メンバ変数
    let id: Int
    let category: String
    let items: [String]
    // イニシャライザ
    init(id: Int, category: String, items: [String]) {
        self.id = id
        self.category = category
        self.items = items
    }
    
}
