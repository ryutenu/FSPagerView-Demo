//
//  HeaderCell.swift
//  FSPagerView-Demo
//
//  Created by Alan Liu on 2021/12/05.
//

import UIKit
import FSPagerView

class HeaderCell: FSPagerViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let titleList = ["千早ぶる", "神代もきかず", "竜田川", "からくれなゐに", "水くくるとは"]
    private let colorList = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(index: Int) {
        guard titleList.indices.contains(index), colorList.indices.contains(index) else {
            return
        }
        backgroundColor = colorList[index]
        
        titleLabel.text = titleList[index]
    }
}
