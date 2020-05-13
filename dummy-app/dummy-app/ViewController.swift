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

    @IBAction func moveLeftCamera(_ sender: NSButton) {
        canvas.worldCamera.eyePos.x -= 0.5
        canvas.render()
    }
    
    @IBAction func moveRightCamera(_ sender: NSButton) {
        canvas.worldCamera.eyePos.x += 0.5
        canvas.render()
    }
    
    @IBAction func moveUpCamera(_ sender: NSButton) {
        canvas.worldCamera.eyePos.y += 0.5
        canvas.render()
    }
    
    @IBAction func moveDownCamera(_ sender: NSButton) {
        canvas.worldCamera.eyePos.y -= 0.5
        canvas.render()
    }
    
    @IBAction func renderButtonTapped(_ sender: NSButton) {
//        let line = Line3D(beginPoint: randomPoint3d(size: canvasSize),
//                          endPoint: randomPoint3d(size: canvasSize),
//                          color: randomCIColor(), endColor: randomCIColor())
//
//        let fragment = Fragment3D(pointA: randomPoint3d(size: canvasSize),
//                                  pointB: randomPoint3d(size: canvasSize),
//                                  pointC: randomPoint3d(size: canvasSize),
//                                  colorA: randomCIColor())
//
//
//        let fragment3d = TextureFragment3D(pointA: randomPoint3d(size: canvasSize), pointB: randomPoint3d(size: canvasSize), pointC: randomPoint3d(size: canvasSize), texImage: NSImage(imageLiteralResourceName: "grass.png"), coordsA: .leftBottom, coordsB: .leftTop, coordsC: .rightBottom)
//
//        canvas.drawObject(object: line)
//        canvas.drawObject(object: fragment)
//        canvas.drawObject(object: fragment3d)
//        canvas.resample()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        canvasSize = CGSize(width: view.frame.size.width, height: max(view.frame.size.height - 56, 0))
        canvas = SRCanvas(size: canvasSize, color: .clear)

        
        for fragment in generateCube(basePoint: Vector3d(1, 0, 0), size: 3) {
            canvas.addObject(object: fragment)
        }

        for line in generateRefrenceLines(distance: 0.5, count: 5) {
            canvas.addObject(object: line)
        }
        
        for line in generateAxis(length: 3) {
            canvas.addObject(object: line)
        }

        view.addSubview(canvas)
        
        canvas.render()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

