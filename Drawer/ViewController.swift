//
//  ViewController.swift
//  Drawer
//
//  Created by Don Magnusson on 5/31/16.
//  Copyright © 2016 DonMag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


	@IBAction func bTapped(sender: AnyObject) {
		
		// create new InfoDrawerView and set its background to green
		let drawerView = InfoDrawerView()
		drawerView.backgroundColor = UIColor.greenColor()
		
		// important - views created via code are set to TRUE
		drawerView.translatesAutoresizingMaskIntoConstraints = false
		
		// array of views (just the one, in this case)
		var views = [String:AnyObject]()
		views["dview"] = drawerView
		
		// add new view to current view (could also be added to a view higher up in the hierarchy)
		self.view.addSubview(drawerView)
		
		// array for constraints
		var dViewConstraints = [NSLayoutConstraint]()

		var vflString = ""
		
		// vertical layout: 70 pixels height, pinned to the bottom of the superview
		vflString = "V:[dview(70)]|"
		
		let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vflString, options: [], metrics: nil, views: views)

		// horizontal layout: pinned to left and right edges of the superview
		vflString = "H:|[dview]|"
		
		let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vflString, options: [], metrics: nil, views: views)

		dViewConstraints += horizontalConstraint + verticalConstraint
		
		// add and activate the constraints
		NSLayoutConstraint.activateConstraints(dViewConstraints)
		
	}
	
}

