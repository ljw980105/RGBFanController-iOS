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
        
        connectButton.rx
            .tap
            .flatMap { _ -> Observable<Void> in
                return BLEManager.current.rx.connect(module: "=ADC_test")
            }
            .subscribe(onNext: { [weak self] _ in
                let vc = SingleColorManagerViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self?.present(nav, animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        BLEManager.current.rx.didReceiveError
            .subscribe(onNext: { error in
                SwiftMessagesWrapper.showErrorMessage(
                    title: "Error",
                    body: error?.localizedDescription ?? "")
            })
            .disposed(by: bag)
        
        BLEManager.current.rx.didReceiveWarning
            .subscribe(onNext: { warning in
                warning.showWarningMessage()
            })
            .disposed(by: bag)
    }
    
    
}

