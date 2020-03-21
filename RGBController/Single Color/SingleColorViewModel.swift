//
//  SingleColorViewModel.swift
//  RGBController
//
//  Created by Jing Wei Li on 3/14/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit
import RxSwift

class SingleColorViewModel {
    var currentColor: UIColor = .black
    let sliderSubject: PublishSubject<UIColor> = PublishSubject()
    let colorPickerSubject: PublishSubject<UIColor> = PublishSubject()
    
    lazy var shouldSetColor: Observable<UIColor> = {
        return Observable
            .merge(sliderSubject, colorPickerSubject)
            .throttle(.milliseconds(100), scheduler: MainScheduler())
    }()
}
