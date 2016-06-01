//
//  ViewController.swift
//  Drawer
//
//  Created by Don Magnusson on 5/31/16.
//  Copyright © 2016 DonMag. All rights reserved.
//

import UIKit


extension UIView {
	func animateConstraintWithDuration(duration: NSTimeInterval = 0.5, delay: NSTimeInterval = 0.0, options: UIViewAnimationOptions = [], completion: ((Bool) -> Void)? = nil) {
		UIView.animateWithDuration(duration, delay:delay, options:options, animations: { [weak self] in
			self?.layoutIfNeeded() ?? ()
			}, completion: completion)
	}
}


class ViewController: UIViewController {

	var gDrawerView: InfoDrawerView?

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.addDrawerView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addDrawerView() {
		
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
		// we want it "closed" to begin with, so put it 70 pixels below the bottom
		vflString = "V:[dview(70)]-(-70)-|"
		
		let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vflString, options: [], metrics: nil, views: views)
		
		// horizontal layout: pinned to left and right edges of the superview
		vflString = "H:|[dview]|"
		
		let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vflString, options: [], metrics: nil, views: views)
		
		dViewConstraints += horizontalConstraint + verticalConstraint
		
		// add the constraints
		self.view.addConstraints(dViewConstraints)
		
		self.gDrawerView = drawerView
	
	}

	@IBAction func bTapped(sender: AnyObject) {

		self.showHideDrawer()
		
	}
	
	func showHideDrawer() {
		
		guard let bCon = self.findBottomConstraint(self.gDrawerView) else {
			return
		}
		
		if bCon.constant == 0 {
			bCon.constant = -70
		} else {
			bCon.constant = 0
		}
		
		self.view.animateConstraintWithDuration(0.25)
		
	}
	
	func findBottomConstraint(targView: UIView?) -> NSLayoutConstraint? {
		var retCon: NSLayoutConstraint?
		
		let fArray = self.view.constraints.filter{
			(($0.firstAttribute == NSLayoutAttribute.Bottom || $0.secondAttribute == NSLayoutAttribute.Bottom)
			&&
			($0.firstItem as? UIView == targView || $0.secondItem as? UIView == targView))
		}
		
		if fArray.count == 1 {
			retCon = fArray[0]
		}
		
		return retCon
	}
	
}

