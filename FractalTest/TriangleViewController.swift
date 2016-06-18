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
		fractalView.layer.addSublayer(drawTriangle(CGRect(origin: CGPointZero, size: fractalView.frame.size), color: UIColor.blackColor()))
		
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
		fractalView.layer.addSublayer(drawTriangle(CGRect(origin: CGPointZero, size: fractalView.frame.size), color: UIColor.blackColor()))
		
		drawFractalIteration(iterations: n,
		                     rect: CGRect(origin: CGPointZero,
							 size: CGSize(width: fractalView.frame.width,
										  height: triangleHeight(fractalView.frame.width))))
		
		fLayer.path = fPath.CGPath
		fractalView.layer.addSublayer(fLayer)
	}
	
	func drawFractalIteration(iterations n: Int, rect: CGRect) {
		if n == 0 {
			return
		} else {
			fPath.appendPath(drawIteration(rect))
		
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
	
	func drawIteration(rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		
		path.moveToPoint(CGPoint(x: rect.origin.x+rect.width/2,
								 y: rect.origin.y))
		path.addLineToPoint(CGPoint(x: rect.origin.x+rect.width*3/4,
									y: rect.origin.y+triangleHeight(rect.width/2)))
		path.addLineToPoint(CGPoint(x: rect.origin.x+rect.width*1/4,
									y: rect.origin.y+triangleHeight(rect.width/2)))
		path.addLineToPoint(CGPoint(x: rect.origin.x+rect.width/2,
									y: rect.origin.y))
		
		return path
	}
	
	// MARK: Triangle drawing
	
	func drawTriangle(rect: CGRect, color: UIColor) -> CALayer {
		let layer = CAShapeLayer()
		let path = UIBezierPath()
		let frame = CGRect(origin: rect.origin,
		                   size: CGSize(width: rect.width,
										height: triangleHeight(rect.width)))
		
		layer.frame = frame
		layer.strokeColor = color.CGColor
		layer.fillColor = UIColor.clearColor().CGColor
		layer.lineWidth = 0.5
		
		path.moveToPoint(frame.origin)
		path.addLineToPoint(CGPoint(x: frame.origin.x+frame.width,
									y: frame.origin.y))
		path.addLineToPoint(CGPoint(x: frame.origin.x+frame.width/2,
									y: frame.origin.y+frame.height))
		path.addLineToPoint(frame.origin)
		
		layer.path = path.CGPath
		
		return layer
	}
	
	func triangleHeight(side: CGFloat) -> CGFloat {
		return (side*sqrt(3))/2
	}
}