//
//  FractalView.swift
//  simple-fractal-app
//
//  Created by Maciej Eichler on 25/10/2016.
//  Copyright © 2016 Mattijah. All rights reserved.
//

import UIKit

class FractalView: UIView {
    
    var path: UIBezierPath? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor?.set()
        UIBezierPath(rect: rect).fill()
        
        tintColor.set()
        path?.stroke()
    }

}
