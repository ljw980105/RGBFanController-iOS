//
//  HSVColorViewController.swift
//  RGBController
//
//  Created by Jing Wei Li on 1/29/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HSVColorViewController: SingleColorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func updateSampledColorView(from color: UIColor) {
        super.updateSampledColorView(from: color)
        updateLabelAndSliders(from: color.hsb())
    }

    func updateLabelAndSliders(from hsb: (h: Int, s: Int, b: Int)) {
        sampleColorLabel1.text = "H: \(hsb.h)"
        sampledColorLabel2.text = "S: \(hsb.s)"
        sampledColorLabel3.text = "B: \(hsb.b)"
        sliderLabel1.text = "Hue: \(hsb.h)"
        sliderLabel2.text = "Saturation: \(hsb.s)"
        sliderLabel3.text = "Brightness: \(hsb.b)"
        slider1.value = Float(hsb.h)
        slider2.value = Float(hsb.s)
        slider3.value = Float(hsb.b)
    }
    
    override func sliderOneUpdated(with value: Float) {
        sliderLabel1.text = "Hue: \(Int(value))"
        sampleColorLabel1.text = "H: \(Int(value))"
    }
    
    override func sliderTwoUpdated(with value: Float) {
        sliderLabel2.text = "Saturation: \(Int(value))"
        sampledColorLabel2.text = "S: \(Int(value))"
    }
    
    override func sliderThreeUpdated(with value: Float) {
        sliderLabel3.text = "Brightness: \(Int(value))"
        sampledColorLabel3.text = "B: \(Int(value))"
    }
    
    override func convertSliderToColor(color: (CGFloat, CGFloat, CGFloat)) -> UIColor {
        let value1 = color.0
        let value2 = color.1
        let value3 = color.2
        return UIColor(hue: value1/255, saturation: value2/255, brightness: value3/255, alpha: 1)
    }

}

extension HSVColorViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "HSB")
    }
}
