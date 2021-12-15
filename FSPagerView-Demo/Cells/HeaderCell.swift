//
//  HeaderCell.swift
//  FSPagerView-Demo
//
//  Created by Alan Liu on 2021/12/05.
//

import UIKit
import FSPagerView

class HeaderCell: FSPagerViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var triangle: UIImageView!
    
    private let titleList = ["千早ぶる", "神代もきかず", "竜田川", "からくれなゐに", "水くくるとは"]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        contentView.backgroundColor = UIColor.clear
        contentView.layer.shadowOpacity = 0
    }
    
    func configureCell(index: Int) {
        bgView.backgroundColor = .systemGray4
        bgView.layer.borderColor = UIColor.systemBrown.cgColor
        bgView.layer.borderWidth = 2
        
        guard titleList.indices.contains(index) else { return }
        titleLabel.text = titleList[index]
        
        triangle.isHidden = true
    }
    
    func updateCell(isCurrent: Bool) {
        bgView.backgroundColor = isCurrent ? .systemBrown : .systemGray4
        
        triangle.isHidden = !isCurrent
    }
}
