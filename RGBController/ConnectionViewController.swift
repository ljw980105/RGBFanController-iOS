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
import JLActivityIndicator

class ConnectionViewController: UIViewController {
    @IBOutlet weak var connectButton: UIButton!
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        connectButton.clipsToBounds = true
        connectButton.layer.cornerRadius = 10
        let activityIndicator = JLActivityIndicator(on: view, mode: .path)
        activityIndicator.enableBackDrop = true
        
        BLEManager.current.start()
        
        connectButton.rx
            .tap
            .flatMap { _ -> Observable<Void> in
                activityIndicator.start()
                return BLEManager.current.rx.connect(module: "SH-HC-08")
            }
            .subscribe(onNext: { [weak self] _ in
                activityIndicator.stop()
                let vc = SingleColorManagerViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                nav.navigationBar.tintColor = UIColor.orange
                self?.present(nav, animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        BLEManager.current.rx.didReceiveError
            .subscribe(onNext: { error in
                activityIndicator.stop()
                SwiftMessagesWrapper.showErrorMessage(
                    title: "Error",
                    body: error?.localizedDescription ?? "")
            })
            .disposed(by: bag)
        
        BLEManager.current.rx.didReceiveWarning
            .subscribe(onNext: { warning in
                activityIndicator.stop()
                warning.showWarningMessage()
            })
            .disposed(by: bag)
    }
    
    
}

