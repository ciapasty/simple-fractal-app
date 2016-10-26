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
	
	// MARK: - Properties
	
	@IBOutlet weak var fractalView: FractalView!
	@IBOutlet weak var iterationLabel: UILabel!
	@IBOutlet weak var iterationStepper: UIStepper!
	
	var fPath = UIBezierPath()
	
	var treeParams = TreeParams()
    
	var globalIterations = 0
	
	// MARK: - ViewController
	
	override func viewDidAppear(_ animated: Bool) {
		drawFractal(iterations: Int(iterationStepper.value))
	}
	
	// MARK: - Actions
	
	@IBAction func stepperValueChanged(_ sender: UIStepper) {
		drawFractal(iterations: Int(sender.value))
		iterationLabel.text = String(Int(sender.value))
	}
	
	@IBAction func redrawFractal(_ sender: UITapGestureRecognizer) {
		drawFractal(iterations: Int(iterationStepper.value))
		globalIterations = Int(iterationStepper.value)
	}
	
	// MARK: - Fractal drawing
	
	func drawFractal(iterations n: Int) {
		fPath = UIBezierPath()
		appendFractalPath(iterations: n,
		                  start: CGPoint(x: fractalView.frame.width/2, y: fractalView.frame.height*3/2),
		                  end: CGPoint(x: fractalView.frame.width/2, y: fractalView.frame.height),
		                  degrees: 0.0)
		fractalView.path = fPath
	}
	
	func appendFractalPath(iterations n: Int, start: CGPoint, end: CGPoint, degrees: Double) {
		
		let iteration:(UIBezierPath, CGPoint) = countIterationPath(start, end: end, degrees: degrees)
		fPath.append(iteration.0)
		
		let killBranchRand = arc4random_uniform(UInt32(11))
		
		if n == 0  {
			return
		} else if (n <= globalIterations-globalIterations/5) && (killBranchRand == 10 && treeParams.killBranch) {
			return
		} else {
			let plusDeg = Double(arc4random_uniform(UInt32(treeParams.angleVar))+UInt32(treeParams.angleBase))
			let minusDeg = Double(arc4random_uniform(UInt32(treeParams.angleVar))+UInt32(treeParams.angleBase))
			
			appendFractalPath(iterations: n-1, start: end, end: iteration.1, degrees: plusDeg)
			appendFractalPath(iterations: n-1, start: end, end: iteration.1, degrees: -minusDeg)
		}
	}
	
	// MARK: - Segment drawing
	
	func countIterationPath(_ start: CGPoint, end: CGPoint, degrees: Double) -> (UIBezierPath, CGPoint) {
		let path = UIBezierPath()
		let vector = (end.x-start.x, end.y-start.y)
		
		//Obrot wektora o 45 stopni
		let sinDeg = CGFloat(sin(CDouble((M_PI/180.0)*degrees)))
		let cosDeg = CGFloat(cos(CDouble((M_PI/180.0)*degrees)))
		
		let newX = vector.0*cosDeg - vector.1*sinDeg
		let newY = vector.0*sinDeg + vector.1*cosDeg
		
		//Losowy dzielnik dlugosci
		let len = CGFloat(arc4random_uniform(UInt32(treeParams.lengthDivVar*10))+UInt32(treeParams.lengthDivMin*10))/10.0
		
		//Nowy wektor
		let endVector = (newX/len, newY/len)
		
		//Nowy punkt
		let newEnd = CGPoint(x: end.x+endVector.0, y: end.y+endVector.1)
		
		path.move(to: end)
		path.addLine(to: newEnd)
		
		return (path, newEnd)
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showTreeParameters" {
			if let destination = segue.destination as? TreeParamsViewController {
				destination.treeParams = treeParams
			}
		}
	}
	
	@IBAction func cancelToTreeView(_ segue: UIStoryboardSegue) {}
	
	@IBAction func doneToTreeView(_ segue: UIStoryboardSegue) {
		if let source = segue.source as? TreeParamsViewController {
			treeParams = source.treeParams
		}
	}

}
