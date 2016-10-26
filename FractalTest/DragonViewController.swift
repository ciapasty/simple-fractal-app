//
//  TriangleViewController.swift
//  FractalTest
//
//  Created by Maciej Eichler on 28/05/16.
//  Copyright © 2016 Mattijah. All rights reserved.
//

import UIKit
import Foundation

class DragonViewController: UIViewController {
	
	// MARK: Properties
	
    @IBOutlet weak var fractalView: FractalView!
	@IBOutlet weak var iterationLabel: UILabel!
	@IBOutlet weak var iterationStepper: UIStepper!
	
	var fPath = UIBezierPath()
	
	// MARK: ViewController
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawFractal(iterations: Int(iterationStepper.value))
    }
	
	// MARK: Actions
	
	@IBAction func stepperValueChanged(_ sender: UIStepper) {
		drawFractal(iterations: Int(sender.value))
		iterationLabel.text = String(Int(sender.value))
	}
	
	// MARK: Fractal drawing
	
	func drawFractal(iterations n: Int) {
        fPath = UIBezierPath()
		appendFractalPath(iterations: n,
		            start: CGPoint(x: fractalView.frame.width/5, y: fractalView.frame.height/2),
		            end: CGPoint(x: fractalView.frame.width*4/5, y: fractalView.frame.height/2))
        
        // Acctual drawing
		fractalView.path = fPath
	}
	
	func appendFractalPath(iterations n: Int, start: CGPoint, end: CGPoint) {
		
		let iteration = countIterationPath(start, end: end)
		
		if n == 0 {
			fPath.append(iteration.path)
			return
		} else {
			appendFractalPath(iterations: n-1, start: start, end: iteration.middlePoint)
			appendFractalPath(iterations: n-1, start: end, end: iteration.middlePoint)
		}
	}
	
	// MARK: Segment counting
	
    func countIterationPath(_ start: CGPoint, end: CGPoint) -> (path: UIBezierPath, middlePoint: CGPoint) {
		let path = UIBezierPath()
		let vector = (end.x-start.x, end.y-start.y)
		
		// 45 degrees vector rotation
		let sin45 = CGFloat(sin(CDouble((M_PI/180.0)*45)))
		let cos45 = CGFloat(cos(CDouble((M_PI/180.0)*45)))
		
		let newX = vector.0*cos45 - vector.1*sin45
		let newY = vector.0*sin45 + vector.1*cos45
		
		// New vector length
		let vectorLen = sqrt(vector.0*vector.0+vector.1*vector.1)
		let midVectorLen = vectorLen/sqrt(2)
		
		// Create new vector
		let midVector = (newX*midVectorLen/vectorLen, newY*midVectorLen/vectorLen)
		
		// Calculate middle point
		let middle = CGPoint(x: start.x+midVector.0, y: start.y+midVector.1)
		
		path.move(to: start)
		path.addLine(to: middle)
		path.addLine(to: end)

		return (path, middle)
	}
}
