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
    
    private let pageCount = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPagerView()
    }
    
    private func setupPagerView() {
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        pagerView.isInfinite = true
        pagerView.itemSize = CGSize(width: 200, height: 50)
        pagerView.interitemSpacing = 20
        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
    }
}

extension ViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        pageCount
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.textLabel?.text = "Page" + String(index)
        return cell
    }
}

extension ViewController: FSPagerViewDelegate {
    
}
