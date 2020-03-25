//
//  NSMenu.swift
//  rEFInd prefs
//
//  Created by Yuma Technical Inc. on 2020-03-13.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Foundation
import AppKit


extension NSMenu {

	func addSeparator() -> Void {
		addItem(.separator())
	}
	
	func addItems(_ items: NSMenuItem...) {
		for item in items {
			addItem(item)
		}
	}


}
