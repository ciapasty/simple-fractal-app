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
		drawFractal(iterations: Int(sender.value))
		iterationLabel.text = String(Int(sender.value))
	}
	
	// MARK: Fractal drawing
	
	func drawFractal(iterations n: Int) {
		fractalView.layer.sublayers = nil
		fPath = UIBezierPath()
		appendFractalPath(iterations: n,
		            start: CGPoint(x: fractalView.frame.width/5, y: fractalView.frame.height/2),
		            end: CGPoint(x: fractalView.frame.width*4/5, y: fractalView.frame.height/2))
		
		fLayer.path = fPath.cgPath
		fractalView.layer.addSublayer(fLayer)
	}
	
	func appendFractalPath(iterations n: Int, start: CGPoint, end: CGPoint) {
		
		let iteration:(UIBezierPath, CGPoint) = countIterationPath(start, end: end)
		
		if n == 0 {
			fPath.append(iteration.0)
			return
		} else {
			appendFractalPath(iterations: n-1, start: start, end: iteration.1)
			appendFractalPath(iterations: n-1, start: end, end: iteration.1)
		}
	}
	
	// MARK: segment drawing
	
	func countIterationPath(_ start: CGPoint, end: CGPoint) -> (UIBezierPath, CGPoint) {
		let path = UIBezierPath()
		let vector = (end.x-start.x, end.y-start.y)
		
		//Obrot wektora o 45 stopni
		let sin45 = CGFloat(sin(CDouble((M_PI/180.0)*45)))
		let cos45 = CGFloat(cos(CDouble((M_PI/180.0)*45)))
		
		let newX = vector.0*cos45 - vector.1*sin45
		let newY = vector.0*sin45 + vector.1*cos45
		
		//Wyliczenie dlugosci nowego wektora
		let vectorLen = sqrt(vector.0*vector.0+vector.1*vector.1)
		let midVectorLen = vectorLen/sqrt(2)
		
		//Nowy wektor
		let midVector = (newX*midVectorLen/vectorLen, newY*midVectorLen/vectorLen)
		
		//Nowy punkt
		let middle = CGPoint(x: start.x+midVector.0, y: start.y+midVector.1)
		
		path.move(to: start)
		
		path.addLine(to: middle)
		
		path.addLine(to: end)

		return (path, middle)
	}
}
