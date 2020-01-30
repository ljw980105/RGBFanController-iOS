//
//  SingleColorViewController.swift
//  RGBController
//
//  Created by Jing Wei Li on 1/28/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit
import RxSwift

class SingleColorViewController: UIViewController {
    @IBOutlet weak var colorView: ColorPicker!
    @IBOutlet weak var pickedColorView: UIView!
    @IBOutlet weak var sampleColorLabel1: UILabel!
    @IBOutlet weak var sampledColorLabel2: UILabel!
    @IBOutlet weak var sampledColorLabel3: UILabel!
    @IBOutlet weak var sliderLabel1: UILabel!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var sliderLabel2: UILabel!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var sliderLabel3: UILabel!
    @IBOutlet weak var slider3: UISlider!
    
    private let bag = DisposeBag()
    
    init() {
        super.init(nibName: "SingleColorViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorView.delegate = self
        setupRx()
        colorView.clipsToBounds = true
        colorView.layer.cornerRadius = 10
    }
    
    @objc func dismissSingleColor() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Overridables
    open func sliderOneUpdated(with value: Float) {
        fatalError("Implement")
    }
    
    open func sliderTwoUpdated(with value: Float) {
        fatalError("Implement")
    }
    
    open func sliderThreeUpdated(with value: Float) {
        fatalError("Implement")
    }
    
    open func updateSampledColorView(from color: UIColor) {
        pickedColorView.backgroundColor = color
    }
    
    open func convertSliderToColor(color: (CGFloat, CGFloat, CGFloat)) -> UIColor {
        fatalError("Implement")
    }
    
    // MARK: - Private
    private func setupRx() {
        slider1.rx.value
            .throttle(0.1, scheduler: MainScheduler())
            .subscribe(onNext: { [weak self] value in
                self?.sliderOneUpdated(with: value)
                self?.setSampleColor()
            })
            .disposed(by: bag)
        
        slider2.rx.value
            .throttle(0.1, scheduler: MainScheduler())
            .subscribe(onNext: { [weak self] value in
                self?.sliderTwoUpdated(with: value)
                self?.setSampleColor()
            })
            .disposed(by: bag)
        
        slider3.rx.value
            .throttle(0.1, scheduler: MainScheduler())
            .subscribe(onNext: { [weak self] value in
                self?.sliderThreeUpdated(with: value)
                self?.setSampleColor()
            })
            .disposed(by: bag)
    }
    
    private func sliderValues() -> (CGFloat, CGFloat, CGFloat) {
        return (CGFloat(slider1.value), CGFloat(slider2.value), CGFloat(slider3.value))
    }
    
    private func setSampleColor() {
        let color = convertSliderToColor(color: sliderValues())
        setColor(color)
        pickedColorView.backgroundColor = color
    }
    
    private func setColor(_ color: UIColor) {
        BLEManager.current.send(
            colorCommand: OutgoingCommands.setColor.rawValue,
            color: color)
    }
}


// MARK: - Color Picker Delegate
extension SingleColorViewController: ColorPickerDelegate {
    func colorPicker(_ colorPicker: ColorPicker, touchedAt point: CGPoint, color: UIColor, state: UIGestureRecognizer.State) {
        setColor(color)
        updateSampledColorView(from: color)
        
    }
}
