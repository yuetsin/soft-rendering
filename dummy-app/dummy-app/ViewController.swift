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
    
    var canvasSize: CGSize!

    @IBAction func renderButtonTapped(_ sender: NSButton) {
        let line = Line3D(beginPoint: randomPoint3d(size: canvasSize),
                          endPoint: randomPoint3d(size: canvasSize),
                          color: randomCIColor(), endColor: randomCIColor())
        canvas.addObject(object: line)
        canvas.render()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        canvasSize = CGSize(width: view.frame.size.width, height: max(view.frame.size.height - 56, 0))
        canvas = SRCanvas(size: canvasSize, color: .clear)

        let line = Line2D(beginPoint: Point2d(x: 10, y: 10),
                        endPoint: Point2d(x: 200, y: 140), color: CIColor.red, endColor: CIColor.blue)

        canvas.addObject(object: line)
        
        let triangle = Triangle(pointA: Point2d(x: 0, y: 0),
                                pointB: Point2d(x: 100, y: 30),
                                pointC: Point2d(x: 50, y: 140),
                                colorA: CIColor.yellow,
                                colorB: CIColor.magenta,
                                colorC: CIColor.cyan)
        
        canvas.addObject(object: triangle)
        view.addSubview(canvas)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

