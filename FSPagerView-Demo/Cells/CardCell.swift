//
//  CardCell.swift
//  FSPagerView-Demo
//
//  Created by Alan Liu on 2021/12/15.
//

import UIKit
import FSPagerView

class CardCell: FSPagerViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let titleList = ["千早ぶる", "神代もきかず", "竜田川", "からくれなゐに", "水くくるとは"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(index: Int) {
        backgroundColor = .systemGray4
        layer.borderColor = UIColor.systemBrown.cgColor
        layer.borderWidth = 2
        
        guard titleList.indices.contains(index) else { return }
        titleLabel.text = titleList[index]
    }
}
