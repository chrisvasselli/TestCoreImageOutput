//
//  ViewController.swift
//  TestCoreImageOutput
//
//  Created by Chris Vasselli on 5/2/20.
//  Copyright © 2020 Serpenti Sei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    // MarioSRGB.png -              Works
    // MarioDisplayP3.png -         Does Not Work   -- works if I change output color space to displayP3
    // door-warningSRGB.jpg -       Does Not Work
    // door-warningSRGB.png -       Works
    // door-warningDisplayP3.jpg -  Does Not Work   -- does not work even with output color space set to displayP3
    // stardew-valleySRGB.jpg -     Does Not Work
    // stardew-vallySRGB.png -      Works
    // stardew-vallyDisplayP3.png - Does Not Work

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoURL = Bundle.main.url(forResource: "MarioSRGB", withExtension: "png")!
        
        let ciImage = CIImage(contentsOf: photoURL, options: [.applyOrientationProperty: true])!

        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("test.jpeg")
        
        let context = CIContext()
        try! context.writeJPEGRepresentation(of: ciImage, to: outputURL, colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!, options: [:])

        let loadedImage = UIImage(contentsOfFile: outputURL.path)
        imageView.image = loadedImage
    }


}

