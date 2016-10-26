//
//  ViewController.swift
//  FractalTest
//
//  Created by Maciej Eichler on 28/05/16.
//  Copyright © 2016 Mattijah. All rights reserved.
//

import UIKit

class SquareViewController: UIViewController {

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
		iterationLabel.text = String(Int(sender.value))
		drawFractal(iterations: Int(sender.value))
	}
	
	// MARK: Fractal drawing
	
	func drawFractal(iterations n: Int) {
		fPath = UIBezierPath()
		drawFractalIteration(iterations: Int(iterationStepper.value),
		                     rect: CGRect(origin: CGPoint.zero, size: fractalView.frame.size))
		fractalView.path = fPath
	}

	func drawFractalIteration(iterations n: Int, rect: CGRect) {
		if n < 0 {
			return
		} else {
			fPath.append(UIBezierPath(rect: rect))
			
			let size = CGSize(width: rect.size.width/3, height: rect.size.height/3)
			let f1Rect = CGRect(origin: CGPoint(x: rect.origin.x,
												y: rect.origin.y),
			                    size: size)
			
			let f2Rect = CGRect(origin: CGPoint(x: rect.origin.x+rect.width/3,
												y: rect.origin.y),
			                    size: size)
			
			let f3Rect = CGRect(origin: CGPoint(x: rect.origin.x+rect.width*2/3,
												y: rect.origin.y),
			                    size: size)
			
			let f4Rect = CGRect(origin: CGPoint(x: rect.origin.x,
												y: rect.origin.y+rect.height/3),
			                    size: size)
			let f5Rect = CGRect(origin: CGPoint(x: rect.origin.x+rect.width*2/3,
												y: rect.origin.y+rect.height/3),
								size: size)
			let f6Rect = CGRect(origin: CGPoint(x: rect.origin.x,
												y: rect.origin.y+rect.height*2/3),
			                    size: size)
			let f7Rect = CGRect(origin: CGPoint(x: rect.origin.x+rect.width/3,
												y: rect.origin.y+rect.height*2/3),
			                    size: size)
			let f8Rect = CGRect(origin: CGPoint(x: rect.origin.x+rect.width*2/3,
												y: rect.origin.y+rect.height*2/3),
			                    size: size)
			
			drawFractalIteration(iterations: n-1, rect: f1Rect)
			drawFractalIteration(iterations: n-1, rect: f2Rect)
			drawFractalIteration(iterations: n-1, rect: f3Rect)
			drawFractalIteration(iterations: n-1, rect: f4Rect)
			drawFractalIteration(iterations: n-1, rect: f5Rect)
			drawFractalIteration(iterations: n-1, rect: f6Rect)
			drawFractalIteration(iterations: n-1, rect: f7Rect)
			drawFractalIteration(iterations: n-1, rect: f8Rect)
		}
	}
}

