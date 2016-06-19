//
//  TreeParamsViewController.swift
//  simple-fractal-app
//
//  Created by Maciej Eichler on 18/06/16.
//  Copyright © 2016 Mattijah. All rights reserved.
//

import UIKit

class TreeParamsViewController: UIViewController {
	
	// MARK: - Properties
	@IBOutlet weak var killBranchesSwitch: UISwitch!
	
	@IBOutlet weak var lengthMinDivSlider: UISlider!
	@IBOutlet weak var lengthDivVarSlider: UISlider!
	@IBOutlet weak var angleMinSlider: UISlider!
	@IBOutlet weak var angleVarSlider: UISlider!
	
	@IBOutlet weak var lengthMinDivLabel: UILabel!
	@IBOutlet weak var lengthDivVarLabel: UILabel!
	@IBOutlet weak var angleMinLabel: UILabel!
	@IBOutlet weak var angleVarLabel: UILabel!
	
	var treeParams = TreeParams()
	
	// MARK: - ViewController
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		lengthMinDivLabel.text = String(treeParams.lengthDivMin)
		lengthDivVarLabel.text = String(treeParams.lengthDivVar)
		angleMinLabel.text = String(treeParams.angleBase)
		angleVarLabel.text = String(treeParams.angleVar)
		
		lengthMinDivSlider.value = treeParams.lengthDivMin
		lengthDivVarSlider.value = treeParams.lengthDivVar
		angleMinSlider.value = treeParams.angleBase
		angleVarSlider.value = treeParams.angleVar
		killBranchesSwitch.on = treeParams.killBranch
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - Actions
	
	@IBAction func killBranchSwitch(sender: UISwitch) {
		treeParams.killBranch = sender.on
	}
	

	@IBAction func sliderValueChanged(sender: UISlider) {
		switch sender {
		case lengthMinDivSlider:
			lengthMinDivLabel.text = String(Int(round(sender.value*100))/100)
			treeParams.lengthDivMin = sender.value
		case lengthDivVarSlider:
			lengthDivVarLabel.text = String(Int(round(sender.value*100))/100)
			treeParams.lengthDivVar = sender.value
		case angleMinSlider:
			angleMinLabel.text = String(Int(sender.value))
			treeParams.angleBase = sender.value
		case angleVarSlider:
			angleVarLabel.text = String(Int(sender.value))
			treeParams.angleVar = sender.value
		default:
			break
		}
	}
	
}