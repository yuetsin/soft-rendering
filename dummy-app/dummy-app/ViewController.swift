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
        
        canvas = SRCanvas(size: CGSize(width: view.frame.size.width, height: max(view.frame.size.height - 56, 0)), color: .clear)

        let line = Line(objectPosition: Point2d(x: 10, y: 10),
                        worldSize: canvas.imageSize,
                        beginPoint: Point2d(x: 10, y: 10),
                        endPoint: Point2d(x: 200, y: 140), color: NSColor.red, endColor: NSColor.blue)

        canvas.drawObject(object: line)
        
        let triangle = Triangle(objectPosition: Point2d(x: 30, y: 50),
                                worldSize: canvas.imageSize,
                                pointA: Point2d(x: 0, y: 0),
                                pointB: Point2d(x: 100, y: 30),
                                pointC: Point2d(x: 50, y: 140),
                                colorA: NSColor.red,
                                colorB: NSColor.green,
                                colorC: NSColor.blue)
        
        canvas.drawObject(object: triangle)
        view.addSubview(canvas)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

