//
//  TriangleViewController.swift
//  FractalTest
//
//  Created by Maciej Eichler on 28/05/16.
//  Copyright © 2016 Mattijah. All rights reserved.
//

import UIKit
import Foundation

class TriangleViewController: UIViewController {

	// MARK: Properties
	
    @IBOutlet weak var fractalView: FractalView!
	@IBOutlet weak var iterationLabel: UILabel!
	@IBOutlet weak var iterationStepper: UIStepper!
	
	let fLayer = CAShapeLayer()
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
		drawFractalIteration(iterations: n, rect: CGRect(origin: CGPoint.zero,
		                                                 size: CGSize(width: fractalView.frame.width,
		                                                              height: triangleHeight(fractalView.frame.width))))
		fractalView.path = fPath
	}
	
	func drawFractalIteration(iterations n: Int, rect: CGRect) {
		if n < 0 {
			return
		} else {
			fPath.append(countTrianglePath(rect))
		
			let size = CGSize(width: rect.size.width/2, height: triangleHeight(rect.size.width/2))
			let f1Rect = CGRect(origin: CGPoint(x: rect.origin.x,
												y: rect.origin.y),
			                    size: size)
			
			let f2Rect = CGRect(origin: CGPoint(x: rect.origin.x+rect.width/2,
												y: rect.origin.y),
			                    size: size)
			
			let f3Rect = CGRect(origin: CGPoint(x: rect.origin.x+size.width/2,
												y: rect.origin.y+triangleHeight(rect.size.width/2)),
			                    size: size)
			
			drawFractalIteration(iterations: n-1, rect: f1Rect)
			drawFractalIteration(iterations: n-1, rect: f2Rect)
			drawFractalIteration(iterations: n-1, rect: f3Rect)
		}
	}
	
	func countTrianglePath(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		let frame = CGRect(origin: rect.origin,
		                   size: CGSize(width: rect.width,
										height: triangleHeight(rect.width)))
		
		path.move(to: frame.origin)
		path.addLine(to: CGPoint(x: frame.origin.x+frame.width,
									y: frame.origin.y))
		path.addLine(to: CGPoint(x: frame.origin.x+frame.width/2,
									y: frame.origin.y+frame.height))
		path.addLine(to: frame.origin)
		
		return path
	}
	
	func triangleHeight(_ side: CGFloat) -> CGFloat {
		return (side*sqrt(3))/2
	}
}
