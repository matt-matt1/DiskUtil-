//
//  MountEntry.swift
//  rEFInd prefs
//
//  Created by Yuma Technical Inc. on 2020-03-14.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


class MountEntry {

	let device: String
	let path: String
	var options: [String]
	var isMounted: Bool
	var canMount: Bool
	let dictionary: [String : AnyObject]

	
	init(device: String, path: String, options: [String], isMounted: Bool, canMount: Bool, dictionary: [String : AnyObject]) {
		self.device = device
		self.path = path
		self.options = options
		self.isMounted = isMounted
		self.canMount = canMount
		self.dictionary = dictionary
	}

	
	func toString() -> String {
		return "MountEntry (DEVICE = \(device), PATH = \(path), OPTIONS = \(options.joined(separator: ", ")), MOUNTED = \(isMounted), CAN = \(canMount)"
	}


}
