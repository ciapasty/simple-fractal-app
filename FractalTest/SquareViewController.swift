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
	
	@IBOutlet weak var fractalView: UIImageView!
	@IBOutlet weak var iterationLabel: UILabel!
	@IBOutlet weak var iterationStepper: UIStepper!
	
	let fLayer = CAShapeLayer()
	var fPath = UIBezierPath()
	
	// MARK: ViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//print("viewDidLoad", fractalView.frame)
	}
	
	override func viewWillAppear(animated: Bool) {
		//print("viewWillAppear", fractalView.frame)
	}
	
	override func viewDidAppear(animated: Bool) {
		//print("viewDidAppear", fractalView.frame)
		//At this point View frames are right size!
		fractalView.layer.addSublayer(drawSquare(CGRect(origin: CGPointZero, size: fractalView.frame.size), color: UIColor.blackColor()))
		
		fLayer.frame = CGRect(origin: CGPointZero, size: fractalView.frame.size)
		fLayer.strokeColor = UIColor.blackColor().CGColor
		fLayer.fillColor = UIColor.clearColor().CGColor
		fLayer.lineWidth = 0.5
		
		drawFractal(iterations: Int(iterationStepper.value))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Actions
	
	@IBAction func stepperValueChanged(sender: UIStepper) {
		iterationLabel.text = String(Int(sender.value))
		
		drawFractal(iterations: Int(sender.value))
	}
	
	// MARK: Fractal drawing
	
	func drawFractal(iterations n: Int) {
		fPath = UIBezierPath()
		fractalView.layer.sublayers = nil
		fractalView.layer.addSublayer(drawSquare(CGRect(origin: CGPointZero, size: fractalView.frame.size), color: UIColor.blackColor()))
		
		drawFractalIteration(iterations: Int(iterationStepper.value),
		                     rect: CGRect(origin: CGPointZero, size: fractalView.frame.size))
		
		fLayer.path = fPath.CGPath
		fractalView.layer.addSublayer(fLayer)
	}

	func drawFractalIteration(iterations n: Int, rect: CGRect) {
		if n == 0 {
			return
		} else {
			fPath.appendPath(drawIteration(rect))
			
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
	
	func drawIteration(rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		
		path.moveToPoint(CGPoint(x: rect.origin.x+rect.width/3,
								 y: rect.origin.y))
		path.addLineToPoint(CGPoint(x: rect.origin.x+rect.width/3,
									y: rect.origin.y+rect.height))
		path.moveToPoint(CGPoint(x: rect.origin.x+rect.width*2/3,
								 y: rect.origin.y))
		path.addLineToPoint(CGPoint(x: rect.origin.x+rect.width*2/3,
									y: rect.origin.y+rect.height))
		path.moveToPoint(CGPoint(x: rect.origin.x,
								 y: rect.origin.y+rect.height/3))
		path.addLineToPoint(CGPoint(x: rect.origin.x+rect.width,
									y: rect.origin.y+rect.height/3))
		path.moveToPoint(CGPoint(x: rect.origin.x,
								 y: rect.origin.y+rect.height*2/3))
		path.addLineToPoint(CGPoint(x: rect.origin.x+rect.width,
									y: rect.origin.y+rect.height*2/3))
		
		return path
	}
	
	// MARK: Draw square
	
	func drawSquare(rect: CGRect, color: UIColor) -> CALayer {
		let layer = CALayer()
		
		layer.frame = rect
		layer.borderWidth = 0.5
		layer.borderColor = color.CGColor
		
		return layer
	}
}

