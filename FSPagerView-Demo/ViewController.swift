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
    
    private func setupPagerView() {
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCell")
        
        pagerView.isInfinite = true
        pagerView.itemSize = CGSize(width: UIScreen.main.bounds.width * 240/375, height: UIScreen.main.bounds.width * 50/375)
        
        let transformer = FSPagerViewTransformer(type: .overlap)
        transformer.minimumAlpha = 1
        transformer.minimumScale = 0.8
        pagerView.transformer = transformer
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
    
}
