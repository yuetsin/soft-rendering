//
//  ViewController.swift
//  dummy-app
//
//  Created by 法好 on 2020/5/12.
//  Copyright © 2020 yuetsin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var canvas: SRCanvas!

    @IBAction func renderButtonTapped(_ sender: NSButton) {
        canvas.render()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        canvas = SRCanvas(size: CGSize(width: view.frame.size.width, height: max(view.frame.size.height - 56, 0)), color: .green)
        
        view.addSubview(canvas)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

