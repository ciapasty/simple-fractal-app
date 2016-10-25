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
	
	override func viewWillAppear(_ animated: Bool) {
		//print("viewWillAppear", fractalView.frame)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		//print("viewDidAppear", fractalView.frame)
		//At this point View frames are right size!
		fractalView.layer.addSublayer(drawTriangle(CGRect(origin: CGPoint.zero, size: fractalView.frame.size), color: UIColor.black))
		
		fLayer.frame = CGRect(origin: CGPoint.zero, size: fractalView.frame.size)
		fLayer.strokeColor = UIColor.black.cgColor
		fLayer.fillColor = UIColor.clear.cgColor
		fLayer.lineWidth = 0.5
		
		drawFractal(iterations: Int(iterationStepper.value))
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: Actions
	
	@IBAction func stepperValueChanged(_ sender: UIStepper) {
		iterationLabel.text = String(Int(sender.value))
		
		drawFractal(iterations: Int(sender.value))
	}
	
	// MARK: Fractal drawing
	
	func drawFractal(iterations n: Int) {
		fPath = UIBezierPath()
		fractalView.layer.sublayers = nil
		fractalView.layer.addSublayer(drawTriangle(CGRect(origin: CGPoint.zero, size: fractalView.frame.size), color: UIColor.black))
		
		drawFractalIteration(iterations: n,
		                     rect: CGRect(origin: CGPoint.zero,
							 size: CGSize(width: fractalView.frame.width,
										  height: triangleHeight(fractalView.frame.width))))
		
		fLayer.path = fPath.cgPath
		fractalView.layer.addSublayer(fLayer)
	}
	
	func drawFractalIteration(iterations n: Int, rect: CGRect) {
		if n == 0 {
			return
		} else {
			fPath.append(drawIteration(rect))
		
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
	
	func drawIteration(_ rect: CGRect) -> UIBezierPath {
		let path = UIBezierPath()
		
		path.move(to: CGPoint(x: rect.origin.x+rect.width/2,
								 y: rect.origin.y))
		path.addLine(to: CGPoint(x: rect.origin.x+rect.width*3/4,
									y: rect.origin.y+triangleHeight(rect.width/2)))
		path.addLine(to: CGPoint(x: rect.origin.x+rect.width*1/4,
									y: rect.origin.y+triangleHeight(rect.width/2)))
		path.addLine(to: CGPoint(x: rect.origin.x+rect.width/2,
									y: rect.origin.y))
		
		return path
	}
	
	// MARK: Triangle drawing
	
	func drawTriangle(_ rect: CGRect, color: UIColor) -> CALayer {
		let layer = CAShapeLayer()
		let path = UIBezierPath()
		let frame = CGRect(origin: rect.origin,
		                   size: CGSize(width: rect.width,
										height: triangleHeight(rect.width)))
		
		layer.frame = frame
		layer.strokeColor = color.cgColor
		layer.fillColor = UIColor.clear.cgColor
		layer.lineWidth = 0.5
		
		path.move(to: frame.origin)
		path.addLine(to: CGPoint(x: frame.origin.x+frame.width,
									y: frame.origin.y))
		path.addLine(to: CGPoint(x: frame.origin.x+frame.width/2,
									y: frame.origin.y+frame.height))
		path.addLine(to: frame.origin)
		
		layer.path = path.cgPath
		
		return layer
	}
	
	func triangleHeight(_ side: CGFloat) -> CGFloat {
		return (side*sqrt(3))/2
	}
}
