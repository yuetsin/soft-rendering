//
//  ViewController.swift
//  dummy-app
//
//  Created by 法好 on 2020/5/12.
//  Copyright © 2020 yuetsin. All rights reserved.
//

import Cocoa
import SwiftUI

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
        canvas.worldCamera.eyePos.z += 0.5
        canvas.render()
    }
    
    @IBAction func moveDownCamera(_ sender: NSButton) {
        canvas.worldCamera.eyePos.z -= 0.5
        canvas.render()
    }
    
    @IBAction func renderButtonTapped(_ sender: NSButton) {
//        let line = Line3D(beginPoint: randomPoint3d(size: canvasSize),
//                          endPoint: randomPoint3d(size: canvasSize),
//                          color: randomCIColor(), endColor: randomCIColor())
//
//        let fragment = GouraudFragment3D(pointA: randomPoint3d(size: CGSize(width: 3, height: 3)),
//                                  pointB: randomPoint3d(size: CGSize(width: 3, height: 3)),
//                                  pointC: randomPoint3d(size: CGSize(width: 3, height: 3)),
//                                  colorA: .cyan,
//                                  colorB: .magenta,
//                                  colorC: .yellow)
        
        let fragment = ShadingFragment3D(tPointA: randomPoint3d(size: CGSize(width: 3, height: 3)),
                                         tPointB: randomPoint3d(size: CGSize(width: 3, height: 3)),
                                         tPointC: randomPoint3d(size: CGSize(width: 3, height: 3)),
                                         material: Material(shininess: defaultShininess, ambientColor: randomCIColor(), diffuseColor: randomCIColor(), specularColor: .white, reflectColor: .white))
//
//
//        let fragment3d = TextureFragment3D(pointA: randomPoint3d(size: CGSize(width: 10, height: 10)),
//                                           pointB: randomPoint3d(size: CGSize(width: 10, height: 10)),
//                                           pointC: randomPoint3d(size: CGSize(width: 10, height: 10)),
//                                                                 texImage: NSImage(imageLiteralResourceName: "grass.png"), coordsA: .leftBottom, coordsB: .leftTop, coordsC: .rightBottom)

//        canvas.drawObject(object: line)
        canvas.addObject(object: fragment)
//        canvas.drawObject(object: fragment3d)
        canvas.render()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        canvasSize = CGSize(width: view.frame.size.width, height: max(view.frame.size.height - 56, 0))
        canvas = SRCanvas(size: canvasSize, color: .clear)

        
        for fragment in generateCube(basePoint: Vector3d(1, 1, 0.1), size: 3) {
            canvas.addObject(object: fragment)
        }

        for line in generateRefrenceLines(distance: 0.5, count: 5) {
            canvas.addObject(object: line)
        }
        
        for line in generateAxis(length: 5) {
            canvas.addObject(object: line)
        }

        canvas.render()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

