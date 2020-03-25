//
//  Mount DataSource.swift
//  viewMount
//
//  Created by Yuma Technical Inc. on 2020-03-15.
//  Copyright © 2020 Yuma Technical Inc. All rights reserved.
//

import Cocoa


extension /*MountVC*/ViewController: NSTableViewDataSource {
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		if tableView == self.detailsTable1 {
			return detailsTable1Data.count
		} else if tableView == self.detailsTable2 {
			return detailsTable2Data.count
		} else {
			return 0
		}
	}
	/*
	func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
		guard let sortDescriptor = tableView.sortDescriptors.first else {
			return
		}
//		if let order = "DeviceCol" {
//		tableView.column(at: sortDescriptor.ascending)
			tableView.sortSubviews({ (view1, view2, UnsafeMutableRawPointer) -> ComparisonResult in
				return ComparisonResult(rawValue: 0)!
			}, context: nil/*UnsafeMutableRawPointer*/)
//		}
		tableView.reloadData()
	}
*/

}

