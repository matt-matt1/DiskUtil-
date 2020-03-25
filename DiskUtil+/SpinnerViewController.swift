//
//  SpinnerViewController.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-25.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa

class SpinnerViewController: NSViewController {

	var spinner = NSProgressIndicator(frame: NSRect(origin: CGPoint.zero, size: CGSize(width: 5, height: 5)))//UIActivityIndicatorView(style: .whiteLarge)
	
	
	override func loadView() {
		view = NSView()
		view.layer?.backgroundColor = NSColor(white: 0, alpha: 0.7).cgColor
		
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.style = NSProgressIndicator.Style.spinning
//		spinner.appearance = NSAppearance(appearanceNamed: NSAppearance.Name.aqua, bundle: nil)
		spinner.startAnimation(nil)
		view.addSubview(spinner)
		
		spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	func showIn(_ viewController: NSViewController) {
		viewController.addChild(self)
		viewController.view.addSubview(self.view)
		self.view.frame = viewController.view.bounds
	}
	
	func dismissSpinner() {
		self.view.removeFromSuperview()
		self.removeFromParent()
	}
    
}
