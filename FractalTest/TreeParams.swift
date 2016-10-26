//
//  TreeParams.swift
//  simple-fractal-app
//
//  Created by Maciej Eichler on 18/06/16.
//  Copyright © 2016 Mattijah. All rights reserved.
//

import Foundation
import UIKit

public struct TreeParams {
	var killBranch: Bool
	var angleBase: Float
	var angleVar: Float
	var lengthDivMin: Float
	var lengthDivVar: Float
	
	init(killBranch: Bool, angleBase: Float, angleVar: Float, lengthDivMin: Float, lengthDivVar: Float) {
		self.killBranch = killBranch
		self.angleBase = angleBase
		self.angleVar = angleVar
		self.lengthDivMin = lengthDivMin
		self.lengthDivVar = lengthDivVar
	}
	
	init () {
		self.killBranch = false
		self.angleBase = 45.0
		self.angleVar = 0.0
		self.lengthDivMin = 2.0
		self.lengthDivVar = 0.0
	}
}
