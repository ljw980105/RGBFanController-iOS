//
//  SingleColorViewController.swift
//  RGBController
//
//  Created by Jing Wei Li on 1/28/20.
//  Copyright © 2020 Jing Wei Li. All rights reserved.
//

import UIKit

class SingleColorViewController: UIViewController {
    @IBOutlet weak var colorView: ColorPicker!
    @IBOutlet weak var colorLabel: UILabel!
    
    init() {
        super.init(nibName: "SingleColorViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissSingleColor))
        colorView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BLEManager.current.disconnect()
    }
    
    @objc func dismissSingleColor() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension SingleColorViewController: ColorPickerDelegate {
    func colorPicker(_ colorPicker: ColorPicker, touchedAt point: CGPoint, color: UIColor, state: UIGestureRecognizer.State) {
        BLEManager.current.send(
            colorCommand: OutgoingCommands.setColor.rawValue,
            color: color)
        let rgb = color.rgb()
        colorLabel.text = "R: \(rgb.r), G: \(rgb.g), B: \(rgb.b)"
    }
    
    
}
