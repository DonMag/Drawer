//
//  ViewController.swift
//  Drawer
//
//  Created by Don Magnusson on 5/31/16.
//  Copyright © 2016 DonMag. All rights reserved.
//

import UIKit

// helper
extension UIView {
	func animateConstraintWithDuration(duration: NSTimeInterval = 0.5, delay: NSTimeInterval = 0.0, options: UIViewAnimationOptions = [], completion: ((Bool) -> Void)? = nil) {
		UIView.animateWithDuration(duration, delay:delay, options:options, animations: { [weak self] in
			self?.layoutIfNeeded() ?? ()
			}, completion: completion)
	}
}


class ViewController: UIViewController {

	var gDrawerView: InfoDrawerView?
	var gBottomConstraint: NSLayoutConstraint?

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
		
		// the "drawer" needs to be hidden when "closed" - otherwise it is partially visible when the device is rotated
		drawerView.hidden = true
		
		// important - views created via code are set to TRUE
		drawerView.translatesAutoresizingMaskIntoConstraints = false
		
		// add new view to current view (could also be added to a view higher up in the hierarchy)
		self.view.addSubview(drawerView)
		
		// array of views (just the one, in this case)
		var views = [String:AnyObject]()
		views["dview"] = drawerView
		
		var vflString = ""
		
		// horizontal layout: pinned to left and right edges of the superview
		vflString = "H:|[dview]|"
		
		let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vflString, options: [], metrics: nil, views: views)
		
		// vertical layout: 70 pixels height
		vflString = "V:[dview(70)]"
		
		let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat(vflString, options: [], metrics: nil, views: views)

		// vertical layout: position of "drawer" view - this will become our modifiable constraint used to show/hide the drawer
		// set to 70 pixels below the bottom of the view, so we can "slide it up"
		let botCon = NSLayoutConstraint(
			item: drawerView,
			attribute: .Bottom,
			relatedBy: NSLayoutRelation.Equal,
			toItem: self.view,
			attribute: .Bottom,
			multiplier: 1,
			constant: 70
		)
		
		// add the constraints
		self.view.addConstraints(horizontalConstraint)
		self.view.addConstraints(verticalConstraint)
		self.view.addConstraint(botCon)
		
		self.gBottomConstraint = botCon
		self.gDrawerView = drawerView
	
	}

	@IBAction func bTapped(sender: AnyObject) {

		if gBottomConstraint?.constant == 0 {
			// the drawer is "open", so slide it down and set to hidden
			
			gBottomConstraint?.constant = 70
			self.view.animateConstraintWithDuration(0.25, delay: 0.0, options: [],
				completion:
				{(finished:Bool)->Void in self.gDrawerView?.hidden = true }
			)
			
		} else {
			// the drawer is "closed", so show it and slide it up
			
			gDrawerView?.hidden = false
			gBottomConstraint?.constant = 0
			self.view.animateConstraintWithDuration(0.25, delay: 0.0, options: [],
				completion: nil
			)
			
		}
		
		return
		
	}
	
}

