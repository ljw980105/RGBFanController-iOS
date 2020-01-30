//
//  RGBColorViewController.swift
//  RGBController
//
//  Created by Jing Wei Li on 1/28/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RGBColorViewController: SingleColorViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func updateSampledColorView(from color: UIColor) {
        super.updateSampledColorView(from: color)
        updateLabelAndSliders(from: color.rgb())
    }

    func updateLabelAndSliders(from rgb: (r: Int, g: Int, b: Int)) {
        sampleColorLabel1.text = "R: \(rgb.r)"
        sampledColorLabel2.text = "G: \(rgb.g)"
        sampledColorLabel3.text = "B: \(rgb.b)"
        sliderLabel1.text = "R: \(rgb.r)"
        sliderLabel2.text = "G: \(rgb.g)"
        sliderLabel3.text = "B: \(rgb.b)"
        slider1.value = Float(rgb.r)
        slider2.value = Float(rgb.g)
        slider3.value = Float(rgb.b)
    }
    
    override func sliderOneUpdated(with value: Float) {
        sliderLabel1.text = "R: \(Int(value))"
        sampleColorLabel1.text = "R: \(Int(value))"
    }
    
    override func sliderTwoUpdated(with value: Float) {
        sliderLabel2.text = "G: \(Int(value))"
        sampledColorLabel2.text = "G: \(Int(value))"
    }
    
    override func sliderThreeUpdated(with value: Float) {
        sliderLabel3.text = "B: \(Int(value))"
        sampledColorLabel3.text = "B: \(Int(value))"
    }
    
    override func convertSliderToColor(color: (CGFloat, CGFloat, CGFloat)) -> UIColor {
        let value1 = color.0
        let value2 = color.1
        let value3 = color.2
        return UIColor(red: value1/255, green: value2/255, blue: value3/255, alpha: 1)
    }
}

extension RGBColorViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "RGB")
    }
}
