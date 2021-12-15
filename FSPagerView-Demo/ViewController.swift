//
//  ViewController.swift
//  FSPagerView-Demo
//
//  Created by Alan Liu on 2021/12/03.
//

import UIKit
import FSPagerView

class ViewController: UIViewController {
    
    @IBOutlet weak var headerPagerView: FSPagerView!
    @IBOutlet weak var cardPagerView: FSPagerView!
    
    private let pageCount = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeaderPagerView()
        setupCardPagerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCellBgColor()
    }
    
    private func setupHeaderPagerView() {
        headerPagerView.dataSource = self
        headerPagerView.delegate = self
        headerPagerView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        
        headerPagerView.isInfinite = true
        headerPagerView.itemSize = CGSize(width: UIScreen.main.bounds.width * 240/375, height: UIScreen.main.bounds.width * 50/375)
        headerPagerView.interitemSpacing = 20
        
        let transformer = PagerViewTransformer(type: .overlap)
        transformer.minimumAlpha = 1
        transformer.minimumScale = 0.8
        headerPagerView.transformer = transformer
    }
    
    private func setupCardPagerView() {
        cardPagerView.dataSource = self
        cardPagerView.delegate = self
        cardPagerView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        
        cardPagerView.isInfinite = true
        cardPagerView.itemSize = CGSize(width: UIScreen.main.bounds.width * 300/375, height: UIScreen.main.bounds.width * 200/375)
        cardPagerView.interitemSpacing = 20
        
        let transformer = PagerViewTransformer(type: .linear)
        transformer.minimumAlpha = 1
        transformer.minimumScale = 0.9
        cardPagerView.transformer = transformer
    }
    
    private func updateCellBgColor() {
        let currentIndex = headerPagerView.currentIndex
        
        for i in 0..<pageCount {
            let cell = headerPagerView.cellForItem(at: i) as? HeaderCell
            
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
        if pagerView == headerPagerView {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", at: index) as! HeaderCell
            cell.configureCell(index: index)
            return cell
        } else if pagerView == cardPagerView {
            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CardCell", at: index) as! CardCell
            cell.configureCell(index: index)
            return cell
        }
        return FSPagerViewCell()
    }
}

extension ViewController: FSPagerViewDelegate {
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        if pagerView == headerPagerView {
            updateCellBgColor()
        }
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        if pagerView == headerPagerView {
            updateCellBgColor()
        }
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
                return
            }
            let scale = max(1 - (1-self.minimumScale) * abs(position), self.minimumScale)
            let transform = CGAffineTransform(scaleX: 1, y: scale)   // Change spot
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
            return pagerView.interitemSpacing   // Change spot
        default:
            break
        }
        return pagerView.interitemSpacing
    }
}
