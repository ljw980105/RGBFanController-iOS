//
//  ConnectionViewController.swift
//  RGBController
//
//  Created by Jing Wei Li on 1/28/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ConnectionViewController: UIViewController {
    @IBOutlet weak var connectButton: UIButton!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        connectButton.clipsToBounds = true
        connectButton.layer.cornerRadius = 10
        
        BLEManager.current.start()
        
        connectButton.rx.tap
            .flatMap { _ -> Observable<Void> in
                return BLEManager.current.rx.connect(module: "=ADC_test")
            }
            .subscribe(onNext: { [weak self] in
                let vc = SingleColorViewController()
                vc.modalPresentationStyle = .overFullScreen
                let nav = UINavigationController(rootViewController: vc)
                self?.present(nav, animated: true, completion: nil)
            })
            .disposed(by: bag)
    }
}

