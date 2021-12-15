//
//  ViewController.swift
//  FSPagerView-Demo
//
//  Created by Alan Liu on 2021/12/03.
//

import UIKit
import FSPagerView

class ViewController: UIViewController {
    
    @IBOutlet weak var pagerView: FSPagerView!
    
    private let pageCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPagerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCellBgColor()
    }
    
    private func setupPagerView() {
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        
        pagerView.isInfinite = true
        pagerView.itemSize = CGSize(width: UIScreen.main.bounds.width * 240/375, height: UIScreen.main.bounds.width * 50/375)
        pagerView.interitemSpacing = 20
        
        let transformer = PagerViewTransformer(type: .overlap)
        transformer.minimumAlpha = 1
        transformer.minimumScale = 0.8
        pagerView.transformer = transformer
    }
    
    private func updateCellBgColor() {
        let currentIndex = pagerView.currentIndex
        
        for i in 0..<pageCount {
            let cell = pagerView.cellForItem(at: i) as? HeaderCell
            
            if i == currentIndex {
                cell?.backgroundColor = .systemBrown
            } else {
                cell?.backgroundColor = .systemGray4
            }
        }
    }
}

extension ViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        pageCount
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", at: index) as! HeaderCell
        cell.configureCell(index: index)
        return cell
    }
}

extension ViewController: FSPagerViewDelegate {
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        updateCellBgColor()
    }
}


// MARK: - Override FSPagerViewTransformer
class PagerViewTransformer: FSPagerViewTransformer {
    override func applyTransform(to attributes: FSPagerViewLayoutAttributes) {
        guard let pagerView = self.pagerView else {
            return
        }
        let position = attributes.position
        let scrollDirection = pagerView.scrollDirection
        switch self.type {
        case .overlap:
            guard scrollDirection == .horizontal else {
                // This type doesn't support vertical mode
                return
            }
            let scale = max(1 - (1-self.minimumScale) * abs(position), self.minimumScale)
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            attributes.transform = transform
            let alpha = (self.minimumAlpha + (1-abs(position))*(1-self.minimumAlpha))
            attributes.alpha = alpha
            let zIndex = (1-abs(position)) * 10
            attributes.zIndex = Int(zIndex)
        case .linear:
            guard scrollDirection == .horizontal else {
                // This type doesn't support vertical mode
                return
            }
            let scale = max(1 - (1-self.minimumScale) * abs(position), self.minimumScale)
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            attributes.transform = transform
            let alpha = (self.minimumAlpha + (1-abs(position))*(1-self.minimumAlpha))
            attributes.alpha = alpha
            let zIndex = (1-abs(position)) * 10
            attributes.zIndex = Int(zIndex)
        default:
            break
        }
    }
    
    override func proposedInteritemSpacing() -> CGFloat {
        guard let pagerView = self.pagerView else {
            return 0
        }
        let scrollDirection = pagerView.scrollDirection
        switch self.type {
        case .overlap:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.itemSize.width * -self.minimumScale * 0.6
        case .linear:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.itemSize.width * -self.minimumScale * 0.2
        default:
            break
        }
        return pagerView.interitemSpacing
    }
}
