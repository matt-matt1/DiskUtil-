//
//  Outline DataSource.swift
//  DiskUtil+
//
//  Created by Yuma Technical Inc. on 2020-03-20.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa



extension ViewController: NSOutlineViewDataSource {
	
	func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
		if let section = item as? DADiskPart {
			return section.Partitions.count
		}
		return myDisks?.AllDisksAndPartitions.count ?? 0
	}
	

	func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
		if let section = item as? DADiskPart {
			return section.Partitions[index]
		}
		return myDisks?.AllDisksAndPartitions[index] ?? ""
	}
	
	
	func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
		if item is DADiskPart {
			return myDisks?.AllDisksAndPartitions.count ?? 0 > 0
		}
		return false
	}


}
