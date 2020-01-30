//
//  SingleColorManagerViewController.swift
//  RGBController
//
//  Created by Jing Wei Li on 1/28/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift

class SingleColorManagerViewController: SegmentedPagerTabStripViewController {
    let bag = DisposeBag()
    
    init() {
        super.init(nibName: "SingleColorManagerViewController", bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSingleColor))
        
        let segment = UISegmentedControl(items: ["HSV", "RGB"])
        segment.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        segment.selectedSegmentIndex = 0
        navigationItem.titleView = segment
        segmentedControl = segment
        
        BLEManager.current.rx
            .didDisconnectFromPeripheral
            .subscribe(onNext: { [weak self] _ in
                self?.dismissSingleColor()
            })
            .disposed(by: bag)
        
    }
    
    @objc func dismissSingleColor() {
        dismiss(animated: true, completion: nil)
        BLEManager.current.disconnect()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //return [RGBColorViewController(), HSVColorViewController()]
        return [HSVColorViewController(), RGBColorViewController()]
    }
}
