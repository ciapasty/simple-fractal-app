//
//  TriangleViewController.swift
//  FractalTest
//
//  Created by Maciej Eichler on 28/05/16.
//  Copyright © 2016 Mattijah. All rights reserved.
//

import UIKit
import Foundation

class TreeViewController: UIViewController {
	
	// MARK: Properties
	
	@IBOutlet weak var fractalView: UIImageView!
	@IBOutlet weak var iterationLabel: UILabel!
	@IBOutlet weak var iterationStepper: UIStepper!
	
	@IBOutlet weak var angleSlider: UISlider!
	@IBOutlet weak var angleLabel: UILabel!
	
	@IBOutlet weak var lengthSlider: UISlider!
	@IBOutlet weak var lengthLabel: UILabel!
	
	@IBOutlet weak var addBranchesSwitch: UISwitch!
	@IBOutlet weak var killBranchesSwith: UISwitch!
	
	let fLayer = CAShapeLayer()
	var fPath = UIBezierPath()
	
	var angleVar: Double = 0.0
	var lengthVar: Double = 0.0
	
	var globalIterations = 0
	
	// MARK: ViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//print("viewDidLoad", fractalView.frame)
		
		angleVar = Double(angleSlider.value)
		angleLabel.text = String(angleVar)
		lengthVar = Double(lengthSlider.value)
		lengthLabel.text = String(lengthVar)
	}
	
	override func viewWillAppear(animated: Bool) {
		//print("viewWillAppear", fractalView.frame)
	}
	
	override func viewDidAppear(animated: Bool) {
		//print("viewDidAppear", fractalView.frame)
		//At this point View frames are right size!
		
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
	
	@IBAction func sliderChanged(sender: UISlider) {
		if sender === angleSlider {
			angleVar = Double(sender.value)
			angleLabel.text = String(angleVar)
		} else if sender === lengthSlider {
			lengthVar = Double(sender.value)
			lengthLabel.text = String(lengthVar)
		}
	}
	
	@IBAction func stepperValueChanged(sender: UIStepper) {
		drawFractal(iterations: Int(sender.value))
		iterationLabel.text = String(Int(sender.value))
	}
	
	@IBAction func redrawFractal(sender: UITapGestureRecognizer) {
		drawFractal(iterations: Int(iterationStepper.value))
		globalIterations = Int(iterationStepper.value)
	}
	
	// MARK: Fractal drawing
	
	func drawFractal(iterations n: Int) {
		fractalView.layer.sublayers = nil
		fPath = UIBezierPath()
		appendFractalPath(iterations: n,
		                  start: CGPoint(x: fractalView.frame.width/2, y: fractalView.frame.height*3/2),
		                  end: CGPoint(x: fractalView.frame.width/2, y: fractalView.frame.height),
		                  degrees: 0.0)
		fLayer.path = fPath.CGPath
		fractalView.layer.addSublayer(fLayer)
	}
	
	func appendFractalPath(iterations n: Int, start: CGPoint, end: CGPoint, degrees: Double) {
		
		let iteration:(UIBezierPath, CGPoint) = countIterationPath(start, end: end, degrees: degrees)
		fPath.appendPath(iteration.0)
		
		let killBranchRand = arc4random_uniform(UInt32(11))
		
		if n == 0  {
			return
		} else if (n <= globalIterations-globalIterations/5) && (killBranchRand == 10 && killBranchesSwith.on) {
			return
		} else {
			let plusDeg = Double(arc4random_uniform(UInt32(angleVar))+15)
			let midDeg = Double(arc4random_uniform(UInt32(angleVar)))
			let minusDeg = Double(arc4random_uniform(UInt32(angleVar))+15)
			
			let branch3rand = arc4random_uniform(UInt32(3))
			
			if branch3rand > 1 && addBranchesSwitch.on {
				appendFractalPath(iterations: n-1, start: end, end: iteration.1, degrees: plusDeg+20.0)
				appendFractalPath(iterations: n-1, start: end, end: iteration.1, degrees: midDeg)
				appendFractalPath(iterations: n-1, start: end, end: iteration.1, degrees: -minusDeg-20.0)
			} else {
				appendFractalPath(iterations: n-1, start: end, end: iteration.1, degrees: plusDeg)
				appendFractalPath(iterations: n-1, start: end, end: iteration.1, degrees: -minusDeg)
			}
		}
	}
	
	// MARK: segment drawing
	
	
	func countIterationPath(start: CGPoint, end: CGPoint, degrees: Double) -> (UIBezierPath, CGPoint) {
		let path = UIBezierPath()
		let vector = (end.x-start.x, end.y-start.y)
		
		//Obrot wektora o 45 stopni
		let sinDeg = CGFloat(sin(CDouble((M_PI/180.0)*degrees)))
		let cosDeg = CGFloat(cos(CDouble((M_PI/180.0)*degrees)))
		
		let newX = vector.0*cosDeg - vector.1*sinDeg
		let newY = vector.0*sinDeg + vector.1*cosDeg
		
		//Losowy dzielnik dlugosci
		let len = CGFloat(arc4random_uniform(UInt32(lengthVar))+12)/10.0
		
		//Nowy wektor
		let endVector = (newX/len, newY/len)
		
		//Nowy punkt
		let newEnd = CGPoint(x: end.x+endVector.0, y: end.y+endVector.1)
		
		path.moveToPoint(end)
		path.addLineToPoint(newEnd)
		
		return (path, newEnd)
	}
}